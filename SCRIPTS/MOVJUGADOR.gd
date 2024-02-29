extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -500.0
var canDash = true
var dashing = false


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
func dash():
	var directionhori =Input.get_axis("LEFT", "RIGHT")
	var directionverti =Input.get_axis("DOWN", "UP")
	if Input.is_action_just_pressed("X") and canDash:
		if directionhori==-1 and directionverti==0:
			velocity=Vector2(directionhori, directionverti)*SPEED*50
			canDash=false
			dashing = true
			await (get_tree().create_timer(0.5))
			dashing = false
			canDash = true
		else:
			if directionhori==1 and directionverti==0:
				velocity=Vector2(directionhori, directionverti)*SPEED*50
				canDash=false
				dashing = true
				await (get_tree().create_timer(0.5))
				dashing = false
				canDash = true
			else:
				if directionhori==0 and directionverti==-1:
					velocity=Vector2(directionhori, directionverti)*SPEED*50
					canDash=false
					dashing = true
					await (get_tree().create_timer(0.5))
					dashing = false
					canDash = true
	#if Input.is_action_just_pressed("X") and canDash:
		#velocity=Vector2(directionhori, directionverti)*SPEED*50
		#canDash=false
		#dashing = true
		#await (get_tree().create_timer(0.5))
		#dashing = false
		#canDash = true
			
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("A") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var directionhori =Input.get_action_strength("RIGHT") - Input.get_action_strength("LEFT")
	var directionverti =Input.get_action_strength("DOWN") - Input.get_action_strength("UP")
	if directionhori:
		velocity.x = directionhori * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	dash()
	move_and_slide()
