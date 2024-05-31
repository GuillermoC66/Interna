extends StatePlayer

class_name DashState

@onready var timer : Timer = $DashTime
@export var canDashAgain : Timer
@export var groundState : StatePlayer
@export var airState : StatePlayer
@export var trailScene = preload("res://RECURSOS/PlayerTrail.tscn")
@export var hitbox : Area2D
@export var dash_Velocity : float
var trail

func Enter():
	stateMachine.can_dash = false
	stateMachine.can_getHurt = false
	playback.travel("dash")
	timer.start(0.25)
	start_trail()
	makeDash()
	
func state_process(_delta):
	timer.timeout.connect(_on_dash_time_timeout)

func _on_dash_time_timeout():
	trail.queue_free()
	hitbox.position = Vector2(0.5, 10)
	if (character.is_on_floor()):
		canDashAgain.start(1)
		Transition.emit(self, groundState)
	else:
		Transition.emit(self, airState)

func makeDash():
	var direccion = Vector2()
	direccion.x = character.directionX
	direccion.y = character.directionY
	if(direccion == Vector2(0,0)):
		direccion.x = character.flipSprite
	character.velocity = direccion * dash_Velocity

func start_trail():
	trail = trailScene.instantiate()
	add_child(trail)
	trail.character = character
	hitbox.scale = Vector2(1, 1)
	if character.flipSprite == 1:
		hitbox.position = Vector2(35.5, 1.5)
	else:
		hitbox.position = Vector2(-35.5, 1.5)

func _on_hitbox_dash_area_entered(area):
	stateMachine.can_dash = true
