extends Node

class_name CameraManager

@export var player : CharacterBody2D
@export var camera_0 : PhantomCamera2D
@export var camera_1 : PhantomCamera2D
@export var camera_2 : PhantomCamera2D
@export var camera_3 : PhantomCamera2D
@export var camera_4 : PhantomCamera2D
@export var camera_5 : PhantomCamera2D
@export var camera_6 : PhantomCamera2D

var current_camera_zone : int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update_current_zone(body, zone1, zone2):
	if body == player:
		match current_camera_zone:
			zone1: current_camera_zone = zone2
			zone2: current_camera_zone = zone1
	update_camera()
			
func update_camera():
	var cameras = [camera_0, camera_1, camera_2, camera_3, camera_4, camera_5, camera_6]
	for camera in cameras:
		if camera != null:
			camera.priority = 0
	match current_camera_zone:
		0: 	camera_0.priority = 1
		1: 	camera_1.priority = 1
		2: 	camera_2.priority = 1
		3: 	camera_3.priority = 1
		4: 	camera_4.priority = 1
		5: 	camera_5.priority = 1
		6: 	camera_6.priority = 1

func _on_zone_01_body_exited(body):
	update_current_zone(body, 0, 1)

func _on_zone_02_body_exited(body):
	update_current_zone(body, 0, 2)

func _on_zone_23_body_exited(body):
	update_current_zone(body, 2, 3)

func _on_zone_34_body_exited(body):
	update_current_zone(body, 3, 4)

func _on_zone_45_body_exited(body):
	update_current_zone(body, 4, 5)

func _on_zone_56_body_exited(body):
	update_current_zone(body, 5, 6)
