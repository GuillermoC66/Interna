extends StatePlayer

class_name HurtState

@onready var knockbackTimer : Timer = $Knockback
@export var inmuneTimer : Timer
@export var groundState : StatePlayer
@export var airState : StatePlayer
@export var hurtVel : float = 1500

func Enter():
	stateMachine.can_move = false
	stateMachine.can_dash = false
	stateMachine.can_getHurt = false
	knockbackTimer.start(0.2)
	inmuneTimer.start(1)
	playback.start("hurt")
	knockback(stateMachine.DamagePosition)

func knockback(damage : Vector2):
	var knockDir = damage.direction_to(character.global_position)
	character.velocity = knockDir * hurtVel
	
func state_process(delta):
	knockbackTimer.timeout.connect(_on_knockback_timeout)
	if (!character.is_on_floor()):
		character.velocity.y += get_gravity() * delta

func _on_knockback_timeout():
	character.velocity.x = 0
	if (character.is_on_floor()):
		stateMachine.can_dash = true
		Transition.emit(self, groundState)
	else:
		Transition.emit(self, airState)
	
	
