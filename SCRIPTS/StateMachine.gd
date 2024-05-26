extends Node

class_name StateMachine

@export var character : CharacterBody2D
@export var animacion : AnimationTree
@export var current_state : StatePlayer

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

	if !new_state:
		return
	
	if current_state:
		current_state.Exit()
	new_state.Enter()
	current_state=new_state

#Puede recibir input de movimiento?
func canMove():
	return current_state.can_move 

#Solo el estado actual puede usar input
func _input(event : InputEvent):
	current_state.state_input(event)
