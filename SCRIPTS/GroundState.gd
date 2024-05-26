extends StatePlayer

class_name GroundState

#Variables de lógica para salto
@export var airState : StatePlayer
@export var camara : Camera2D

#CollisionShapes para agacharse
var shape_stand = preload("res://RECURSOS/collisionStand.tres")
var shape_crouch = preload("res://RECURSOS/collisionCrouch.tres")

#Variables de lógica para dash
#@export var dash_state : State
#@export var dash_animation : String = "dash"

func state_process(delta):
	# Agregar gravedad a jugador
	if (!character.is_on_floor()):
		character.velocity.y += get_gravity() * delta
		Transition.emit(self, airState)

func state_input(event : InputEvent):	
	jump()	
	if(event.is_action_pressed("ui_up")):
		lookUp()
	elif(event.is_action_pressed("ui_down")):
		crouch()
	elif(event.is_action_released("ui_down") || event.is_action_released("ui_up")):
		stopCrouch()

#Salto	
func jump():
	if Input.is_action_just_pressed("ui_select"):
		character.velocity.y = jump_velocity
	
#Cambiar CollisionShape		
func crouch():
	can_move = false
	character.collision_shape.shape = shape_crouch
	character.collision_shape.position.y = 25
	playback.travel("transCrouch")
	
#Regresar la CollisionShape a su forma original		
func stopCrouch():
	can_move = true
	character.collision_shape.shape = shape_stand
	character.collision_shape.position.y = 10
	playback.travel("runnin")

#Mirar arriba	
func lookUp():
	can_move = false
	playback.travel("transLookUp")

