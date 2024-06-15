extends Control

@onready var animacion : AnimationPlayer = $AnimationPlayer
@onready var test_level = preload("res://ESCENAS/elmundo.tscn") as PackedScene

func _ready():
	animacion.play("death")

func state_process(delta):
	if Input.is_anything_pressed():
		print("wa")
		get_tree().change_scene_to_packed(test_level)
