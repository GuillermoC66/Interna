extends Camera2D

class_name Camara

@export var speed = 5
@onready var player : CharacterBody2D = $"../Player"
@onready var managerLimit : CameraLimitManager = $ManagerLimit

@export var valorOffset = 30

func _physics_process(delta):
	#Seguimiento horizontal con offset
	position.y = lerpf (position.y, player.position.y, (speed * delta)/2) - 10
	if(player.flipSprite > 0):
		position.x = lerpf (position.x, player.position.x, speed * delta) + valorOffset
	elif(player.flipSprite < 0):
		position.x = lerpf (position.x, player.position.x, speed * delta) - valorOffset
