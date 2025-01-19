extends CharacterBody2D

func _on_hurtbox_area_entered(area):
	if area.is_in_group("HitboxDash"):
		#print("flyfish dice: ouch!")
		queue_free()
