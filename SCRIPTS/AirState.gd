extends State

class_name AirState

#Se puede mover de lado a lado
#puede hacer dash
#Variables de lógica para salto
@export var groundState : State

func state_process(delta):
	if(character.is_on_floor()):
		next_state = groundState

