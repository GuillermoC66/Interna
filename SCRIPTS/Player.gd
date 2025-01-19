extends CharacterBody2D

class_name Player
#Nodos necesarios
@onready var animacion : AnimationTree = $AnimationTree
@onready var hitboxDash : Area2D = $HitboxDash
@onready var collision_shape : CollisionShape2D = $CollisionShape2D
@onready var stateMachine : StateMachine = $StateMachine

@export var camera : Camera2D

#Movimiento
var directionX : float = 0
var directionY : float = 0
var velocidadCaminar : float = 800
var velocidadCorrer : float = 1700

#Animacion
var playback
var flipSprite = 1
var life = 3

func _ready():
	hitboxDash.scale = Vector2(0.1, 0.1)
	animacion.active = true
	playback = animacion["parameters/playback"]
	
func _physics_process(_delta):
	if stateMachine.canMove() and stateMachine.current_state.name != "Dash":
		directionX = Input.get_axis("ui_left", "ui_right")
		directionY = Input.get_axis("ui_up", "ui_down")
		if Input.is_action_pressed("walk"):
			walkRun(velocidadCaminar, "walk")
		else:
			walkRun(velocidadCorrer, "run")
		animacionesJump()
	move_and_slide()

#Movimiento horizontal (Correr, caminar)
func walkRun(velocidad, animacionAsignada):
	if directionX:
		spriteDirection()
		velocity.x = directionX * velocidad
		playback.travel(animacionAsignada)
	else:
		velocity.x = move_toward(velocity.x, 0, velocidad)
		if velocity.y == 0:
			playback.travel("idle")
	
#Verificar direccion del sprite
func spriteDirection():
	if directionX == -1:
		#moveCamera(-1)
		get_node("AnimatedSprite2D").flip_h = true
		flipSprite = -1
	elif directionX == 1:
		#moveCamera(1)
		get_node("AnimatedSprite2D").flip_h = false
		flipSprite = 1

#Verificar la animacion de salto y caer
func animacionesJump():
	if(velocity.y < 0):
		playback.travel("jump")
	elif(velocity.y > 0) and !stateMachine.coyote_jump:
		playback.travel("fall")
		
#func moveCamera(direccion):
	#if (camera.position != Vector2(-145, 0) && flipSprite == -1) && (camera.position != Vector2(145, 0) && flipSprite == 1):
	#	camera.position += direccion * Vector2(100, 0) * 0.5
		
func die():
	print("me mori")
	#poner animaciones de muerte y demas.
