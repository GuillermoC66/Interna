extends CharacterBody2D

const SPEED = 400.0
const JUMP_VELOCITY = -600.0
const DASH_SPEED=600
var canDash=true
var dashing = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
	
func get_move_direction():
	return Vector2(
		(float(Input.is_action_pressed('RIGHT')) - float(Input.is_action_pressed('LEFT')))*5.4,
		float(Input.is_action_pressed('DOWN')) - float(Input.is_action_pressed('UP')))

func _physics_process(delta):
	#GRAVEDAD
	velocity.y += gravity*delta*2
	#CHECA SI ESTAS EN PISO
	if is_on_floor():
		canDash = true
	#SALTO
	if Input.is_action_just_pressed("A") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	#MOVIMIENTO HORIZONTAL
	var directionhori =Input.get_action_strength("RIGHT") - Input.get_action_strength("LEFT")
	if directionhori:
		velocity.x = directionhori * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	#DASH SIN ATAQUE TODAVÍA
	var move_direction = get_move_direction()
	if Input.is_action_just_pressed("X") and canDash==true:
		velocity = move_direction*DASH_SPEED
		canDash=false
		dashing = true
		dashing = false
	#FUNCION ESPECIFICA DE GODOT QUE TE DEJA MOVERTE	
	move_and_slide()
	#AGARRAR PARED
	#FRICCION PARED
	#SALTO PARED
	#HEAVY DASH
	#ESCUDO
	#RECIBIR DAÑO
	#IMPLEMENTAR ANIMACIONES
	#
