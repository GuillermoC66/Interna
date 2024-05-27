extends StatePlayer

class_name DashState

@onready var timer : Timer = $Timer
@export var groundState : StatePlayer
@export var airState : StatePlayer
@export var trailScene = preload("res://RECURSOS/PlayerTrail.tscn")
@export var dash_Velocity : float
var trail

func Enter():
	if(can_dash):
		playback.travel("dash")
		timer.start(0.25)
		start_trail()
		get_direction()
	
func state_process(delta):
	timer.timeout.connect(_on_Timer_timeout)

func _on_Timer_timeout():
	trail.queue_free()
	#playback.travel("idle")
	if (character.is_on_floor()):
		can_dash = true
		Transition.emit(self, groundState)
	else:
		Transition.emit(self, airState)

func get_direction():
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
	
