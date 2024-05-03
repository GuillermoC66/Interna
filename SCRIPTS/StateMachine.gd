extends Node

class_name StateMachine

@export var character : CharacterBody2D
@export var animacion : AnimationTree
@export var current_state : State

var states : Array[State]

func _ready():
	for child in get_children():
		if(child is State):
			states.append(child)
			child.character = character
			child.playback = animacion["parameters/playback"]
			
		else:
			push_warning("Child " + child.name + " is not a State for CharacterStateMachine")

func _physics_process(delta):
	if(current_state.next_state != null):
		switchState(current_state.next_state)
	current_state.state_process(delta)
	
func canMove():
	return current_state.can_move 

func _input(event : InputEvent):
	current_state.state_input(event)

func switchState(newState : State):
	if(current_state != null):
		current_state.on_exit()
		current_state.next_state = null
	current_state = newState
	current_state.on_enter()
