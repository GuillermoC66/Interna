extends Area2D

class_name LimiteCamara

enum LimiteX {NONE, LEFT, RIGHT}
enum LimiteY {NONE, TOP, BOTTOM}

const MAX_VAL = 100000

@export var limite_x : LimiteX = LimiteX.NONE
@export var limite_y : LimiteY = LimiteY.NONE

@onready var marker = $limite

#obtener limites verticales
func get_limit_top():
	if limite_y != LimiteY.TOP:
			return -MAX_VAL
	return marker.global_position.y
	
func get_limit_bottom():
	if limite_y != LimiteY.BOTTOM:
			return MAX_VAL
	return marker.global_position.y
	
	#obtener limites horizontales
func get_limit_left():
	if limite_x != LimiteX.LEFT:
			return -MAX_VAL
	return marker.global_position.x
	
func get_limit_right():
	if limite_x != LimiteX.RIGHT:
			return MAX_VAL
	return marker.global_position.x
