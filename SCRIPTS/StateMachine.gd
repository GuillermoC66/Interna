extends Node

class_name StateMachine

var DamagePosition
@export var character : CharacterBody2D
@export var animacion : AnimationTree
@export var current_state : StatePlayer
@export var hurt_state : StatePlayer
var can_move : bool = true
var can_dash : bool = true
var can_getHurt : bool = true

var states : Array[StatePlayer]

func _ready():
	for child in get_children():
		if(child is StatePlayer):
			states.append(child)
			child.character = character
			child.playback = animacion["parameters/playback"]
			child.Transition.connect(on_child_transition)
	
func _physics_process(delta):
	if(current_state):
		current_state.state_process(delta)

#Cambio entre estados
func on_child_transition(state, new_state):
	if state != current_state:
		return
	current_state.Exit()
	current_state=new_state
	current_state.Enter()

#Puede recibir input de movimiento?
func canMove():
	return can_move 

#Solo el estado actual puede usar input
func _input(event : InputEvent):
	current_state.state_input(event)

#Al recibir daño, entra al estado Hurt
func _on_hurtbox_area_entered(area):
	if area.is_in_group("Hitbox") and can_getHurt:
		DamagePosition = area.global_position
		character.life -= 1
		on_child_transition(current_state, hurt_state)
		
func _on_can_dash_again_timeout():
	can_dash = true

func _on_inmunity_timeout():
	can_getHurt = true
