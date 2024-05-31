extends Control

@onready var animacion : AnimationPlayer = $AnimationPlayer

func resume():
	get_tree().paused = false
	animacion.play_backwards("blur")

func pause():
	get_tree().paused = true
	animacion.play("blur")

func escKey():
	if Input.is_action_just_pressed("esc"):
		if !get_tree().paused:
			pause()
		else:
			resume()

func _on_resume_button_pressed():
	resume()

func _on_restart_button_pressed():
	get_tree().reload_current_scene()
	
func _process(_delta):
	if !get_tree().paused:
		self.hide()
	else:
		self.show()
	escKey()

func _on_quit_button_pressed():
	get_tree().quit()

func _on_button_pressed():
	pause()
