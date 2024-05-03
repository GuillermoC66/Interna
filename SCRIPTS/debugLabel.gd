extends Label

@export var maquinaEstado : StateMachine
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	text = "Estado actual: " + maquinaEstado.current_state.name
