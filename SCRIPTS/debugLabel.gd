extends Label

@export var maquinaEstado : StateMachine
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	text = "Estado: " + maquinaEstado.current_state.name + 	" Dash: " + str(maquinaEstado.can_dash) + " Move: " + str(maquinaEstado.can_move) + " herido " + str(maquinaEstado.can_getHurt)
