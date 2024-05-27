extends CharacterBody2D
#Nodos necesarios
@onready var animacion : AnimationTree = $AnimationTree
@onready var collision_shape : CollisionShape2D = $CollisionShape2D
@onready var stateMachine : StateMachine = $StateMachine

var directionX : float = 0
var directionY : float = 0
var playback
var flipSprite
var velocidadCaminar : float = 410
var velocidadCorrer : float = 700

func _ready():
	animacion.active = true
	playback = animacion["parameters/playback"]
	
func _physics_process(delta):
	if stateMachine.canMove():
		directionX = Input.get_axis("ui_left", "ui_right")
		directionY = Input.get_axis("ui_up", "ui_down")
		if Input.is_action_pressed("walk"):
			walkRun(velocidadCaminar, "walk")
		else:
			walkRun(velocidadCorrer, "run")
	animacionesJump()
	move_and_slide()

#Movimiento horizontal (Correr, caminar)
func walkRun(velocidad, animacion):
	if directionX:
		spriteDirection()
		velocity.x = directionX * velocidad
		playback.travel(animacion)
	else:
		velocity.x = move_toward(velocity.x, 0, velocidad)
		if velocity.y == 0:
			playback.travel("idle")
	
#Verificar direccion del sprite
func spriteDirection():
	if directionX == -1:
		get_node("AnimatedSprite2D").flip_h = true
		flipSprite = -1
	elif directionX == 1:
		get_node("AnimatedSprite2D").flip_h = false
		flipSprite = 1

#Verificar la animacion de salto y caer
func animacionesJump():
	if(velocity.y < 0):
		playback.travel("jump")
	elif(velocity.y > 0):
		playback.travel("fall")
