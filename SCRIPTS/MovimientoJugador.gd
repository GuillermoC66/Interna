extends CharacterBody2D
#Nodos necesarios
#@onready var animacion = get_node("AnimationPlayer")
@onready var animacion : AnimationTree = $AnimationTree
@onready var collision_shape : CollisionShape2D = $CollisionShape2D
@onready var stateMachine : StateMachine = $StateMachine

#Velocidad de movimiento
const SPEED = 600.0
var direction : float = 0
var playback
var jump_velocity : float

func _ready():
	animacion.active = true
	playback = animacion["parameters/playback"]
	
func _physics_process(delta):
	# Agregar gravedad a jugador
	if not is_on_floor():
		velocity.y += get_gravity() * delta
	
	animacionesJump()

	if stateMachine.canMove():
		direction = Input.get_axis("ui_left", "ui_right")
		walkRun()
		jump()
		
	move_and_slide()

#Devuelve gravedad
func get_gravity() -> float:
	#Constantes que modifican salto.
	const jump_height = 200.0 #Alto del salto,
	const jump_peak = 0.45 #Tiempo que toma llegar a lo alto
	const jump_fall = 0.35 #Tiempo que toma en caer

	#Operaciones necesarias para el salto
	jump_velocity = -((2.0 * jump_height) / jump_peak)
	var jump_gravity : float = -((-2.0 * jump_height) / (jump_peak * jump_peak))
	var fall_gravity : float = -((-2.0 * jump_height) / (jump_fall * jump_fall))
	return jump_gravity if velocity.y < 0.0  else fall_gravity
	
#Salto	
func jump():
	if Input.is_action_just_pressed("ui_select"):
		velocity.y = jump_velocity
	elif Input.is_action_just_released("ui_select") && velocity.y < 0:
		velocity.y = 0
	
#Movimiento horizontal (Correr, caminar)
func walkRun():
	if direction:
		spriteDirection()
		velocity.x = direction * SPEED
		if velocity.y == 0:
			playback.travel("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0:
			playback.travel("idle")
	
#Verificar direccion del sprite
func spriteDirection():
	if direction == -1:
		get_node("AnimatedSprite2D").flip_h = true
	elif direction == 1:
		get_node("AnimatedSprite2D").flip_h = false

#Verificar la animacion de salto y caer
func animacionesJump():
	if(velocity.y < 0):
		playback.travel("jump")
	elif(velocity.y > 0):
		playback.travel("fall")
