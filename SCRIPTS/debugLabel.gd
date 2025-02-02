extends Label

@export var player : CharacterBody2D
@export var cameraMan : CameraManager

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var maquinaEstado = player.stateMachine
	text = "Estado: " + maquinaEstado.current_state.name + 	 	"\nDash: " + str(maquinaEstado.can_dash) + "\nMove: " + str(maquinaEstado.can_move) + "\nHurt: " + str(maquinaEstado.can_getHurt) + "\nCoyote: " + str(maquinaEstado.coyote_jump) + "\nDireccion: " + str(player.directionX) + " , " +  str(player.directionY) + "\nZona: " + str(cameraMan.current_camera_zone)  
