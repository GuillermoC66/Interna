extends Node2D

@onready var character : CharacterBody2D = $Player
var pjVivo : bool = true

func _process(_delta):
	if character.life == 0:
		gameOver()

func _on_area_2d_area_entered(area):
	if area.is_in_group("Player"):
		gameOver()

func gameOver():
	get_tree().reload_current_scene()
	#get_tree().change_scene_to_packed(gameOver_scene)
	
