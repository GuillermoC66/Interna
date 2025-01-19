extends Camera2D

@onready var player : CharacterBody2D = get_parent()

var valorOffset = 100

func _physics_process(delta):
	#Seguimiento horizontal con offset
	if(player.flipSprite > 0):
		drag_horizontal_offset = 1
		offset.x = lerpf (offset.x, valorOffset, 0.01)
		#offset.x = 100
	elif(player.flipSprite < 0):
		drag_horizontal_offset = -1
		offset.x = lerpf (offset.x, -valorOffset,  0.01)
		#offset.x = -200
		
