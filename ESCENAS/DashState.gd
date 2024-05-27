extends StatePlayer

class_name DashState

@onready var timer : Timer = $Timer
@export var groundState : StatePlayer
@export var airState : StatePlayer
@export var trailScene = preload("res://RECURSOS/PlayerTrail.tscn")
@export var dash_Velocity : float
var trail

func Enter():
	timer.start(1)
	trail = trailScene.instantiate()
	add_child(trail)
	trail.character = character
	get_direction()
	
func state_process(delta):
	timer.timeout.connect(_on_Timer_timeout)

func _on_Timer_timeout():
	trail.queue_free()
	if (character.is_on_floor()):
		Transition.emit(self, groundState)
	else:
		Transition.emit(self, airState)

func get_direction():
	var direccion = Vector2()
	direccion.x = character.directionX
	direccion.y = character.directionY
	print(direccion)
	if(direccion == Vector2(0,0)):
		direccion.x = character.flipSprite
	
	character.velocity += direccion * dash_Velocity

