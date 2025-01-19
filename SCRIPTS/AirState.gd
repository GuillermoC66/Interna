extends StatePlayer

class_name AirState

@export var groundState : StatePlayer
@export var dashState : StatePlayer


func Enter():
	stateMachine.can_move = true
	stateMachine.coyoteTime.start(0.2)
	stateMachine.coyote_jump = true

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
	if Input.is_action_just_pressed("ui_select") and stateMachine.coyote_jump:
		jump()

func jump():
	character.velocity.y = jump_velocity
	stateMachine.coyote_jump = false

func stopJump():
	if !Input.is_action_pressed("ui_select") && character.velocity.y < 0:
		character.velocity.y = 0
	
func _on_timer_timeout():
	stateMachine.coyote_jump = false
