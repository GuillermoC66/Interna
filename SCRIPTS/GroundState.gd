extends StatePlayer

class_name GroundState

#Variables de lógica para salto
@export var airState : StatePlayer
@export var dashState : StatePlayer
@export var camara : Camera2D
@export var hurtbox : Area2D

#CollisionShapes para agacharse
var shape_stand = preload("res://RECURSOS/collisionStand.tres")
var shape_crouch = preload("res://RECURSOS/collisionCrouch.tres")
@onready var timer : Timer = $Timer
var movimiento = Vector2(0, 150)
var direccion

func Enter():
	playback.travel("idle")
	
func state_process(delta):
	# Agregar gravedad a jugador
	if (!character.is_on_floor()):
		character.velocity.y += get_gravity() * delta
		Transition.emit(self, airState)

func state_input(event : InputEvent):	
	jump()	
	if(event.is_action_pressed("dash") and stateMachine.can_dash):
		Transition.emit(self, dashState)
	if(event.is_action_pressed("ui_up")):
		lookUp()
	elif(event.is_action_pressed("ui_down")):
		crouch()
	elif(event.is_action_released("ui_down") || event.is_action_released("ui_up") || event.is_action_pressed("ui_left") || event.is_action_pressed("ui_right")):
		stopCrouch()

#Salto	
func jump():
	if Input.is_action_just_pressed("ui_select"):
		character.velocity.y = jump_velocity
	
#Cambiar CollisionShape		
func crouch():
	detenerse()
	hurtbox.position.y = 24
	hurtbox.scale.y = 0.5
	character.collision_shape.shape = shape_crouch
	character.collision_shape.position.y = 25
	playback.travel("transCrouch")
	timer.start()
	direccion = 1
	timer.timeout.connect( _on_timer_timeout)

#Mirar arriba	
func lookUp():
	detenerse()
	playback.travel("transLookUp")
	timer.start()
	direccion = -1
	timer.timeout.connect( _on_timer_timeout)

#Regresar la CollisionShape a su forma original		
func stopCrouch():
	character.camera.position= Vector2(-145, 0)
	stateMachine.can_move = true
	hurtbox.position.y = 0
	hurtbox.scale.y = 1
	character.collision_shape.shape = shape_stand
	character.collision_shape.position.y = 10
	
func detenerse():
	character.velocity.x = 0
	stateMachine.can_move = false

func _on_timer_timeout():
	character.camera.position += direccion * movimiento * 0.9
