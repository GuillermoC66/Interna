extends Area2D

@onready var player : CharacterBody2D = get_parent()

func _on_area_entered(area: Area2D):
	if area is LimiteCamara:
		player.camera.managerLimit.set_limiter(area)
