extends StatePlayer

class_name AirState

@export var groundState : StatePlayer
@export var dashState : StatePlayer

func state_process(delta):
	if (!character.is_on_floor()):
		character.velocity.y += get_gravity() * delta
		stopJump()
	else:
		stateMachine.can_dash = true
		Transition.emit(self, groundState)

func state_input(event : InputEvent):	
	if(event.is_action_pressed("dash") and stateMachine.can_dash):
		Transition.emit(self, dashState)

func stopJump():
	if !Input.is_action_pressed("ui_select") && character.velocity.y < 0:
		character.velocity.y = 0
	

