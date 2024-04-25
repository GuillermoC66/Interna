extends CharacterBody2D

#Velocidad de movimiento
const SPEED = 600.0

#Constantes que modifican salto.
const jump_height = 200.0 #Alto del salto,
const jump_peak = 0.5 #Tiempo que toma llegar a lo alto
const jump_fall = 0.4 #Tiempo que toma en caer

#Operaciones necesarias para el salto
@onready var jump_velocity : float = -((2.0 * jump_height) / jump_peak)
@onready var jump_gravity : float = -((-2.0 * jump_height) / (jump_peak * jump_peak))
@onready var fall_gravity : float = -((-2.0 * jump_height) / (jump_fall * jump_fall))

#CollisionShapes para agacharse
var shape_stand = preload("res://RECURSOS/collisionStand.tres")
var shape_crouch = preload("res://RECURSOS/collisionCrouch.tres")

#Nodos necesarios
@onready var animacion = get_node("AnimationPlayer")
@onready var collision_shape = $CollisionShape2D

func get_gravity() -> float:
	return jump_gravity if velocity.y < 0.0  else fall_gravity

func _physics_process(delta):
	collision_shape.position.y = 10
	# Agregar gravedad a jugador
	if not is_on_floor():
		velocity.y += get_gravity() * delta
		
	# Salto
	if Input.is_action_just_pressed("ui_select") and is_on_floor():
		velocity.y = jump_velocity
		animacion.play("jump")
	if Input.is_action_just_released("ui_select"):
			velocity.y = 0
	if velocity.y > 0:
			animacion.play("fall")
	
	#Direccionales
	var crouch = Input.get_axis("ui_up", "ui_down")
	var direction = Input.get_axis("ui_left", "ui_right")
	
	#Agacharse y mirar arriba
	if crouch and is_on_floor():
		if crouch == -1:
			animacion.play("lookup")
		elif crouch == 1:
			collision_shape.shape = shape_crouch
			collision_shape.position.y = 25
			animacion.play("crouch")
	
	#Regresar la CollisionShape a su forma original		
	if Input.is_action_just_released("ui_down"):
		collision_shape.shape = shape_stand
		collision_shape.position.y = 10
		
	#Movimiento horizontal (Correr, caminar)
	if direction:
		if direction == -1:
			get_node("AnimatedSprite2D").flip_h = true
		elif direction == 1:
			get_node("AnimatedSprite2D").flip_h = false
		velocity.x = direction * SPEED
		if velocity.y == 0 :
			animacion.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if is_on_floor() and velocity.y == 0 and velocity.x == 0 and crouch == 0:
		animacion.play("idle")	
	
	move_and_slide()
