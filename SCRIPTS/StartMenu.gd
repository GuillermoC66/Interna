extends Control

@onready var test_level = preload("res://ESCENAS/elmundo.tscn") as PackedScene
@onready var startButton : Button = $PanelContainer/VBoxContainer/StartButton
@onready var quitButton : Button = $PanelContainer/VBoxContainer/QuitButton

func _ready():
	startButton.button_down.connect(_on_start_button_pressed)
	quitButton.button_down.connect(_on_quit_button_pressed)

func _on_start_button_pressed():
	get_tree().change_scene_to_packed(test_level)

func _on_quit_button_pressed():
	get_tree().quit()
