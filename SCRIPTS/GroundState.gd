extends StatePlayer

class_name GroundState

#Variables de lógica para salto
@export var airState : StatePlayer
@export var dashState : StatePlayer
@export var camara : Camera2D

#CollisionShapes para agacharse
var shape_stand = preload("res://RECURSOS/collisionStand.tres")
var shape_crouch = preload("res://RECURSOS/collisionCrouch.tres")

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
	character.collision_shape.shape = shape_crouch
	character.collision_shape.position.y = 25
	playback.travel("transCrouch")
	
#Regresar la CollisionShape a su forma original		
func stopCrouch():
	stateMachine.can_move = true
	character.collision_shape.shape = shape_stand
	character.collision_shape.position.y = 10

#Mirar arriba	
func lookUp():
	detenerse()
	playback.travel("transLookUp")

func detenerse():
	character.velocity.x = 0
	stateMachine.can_move = false
