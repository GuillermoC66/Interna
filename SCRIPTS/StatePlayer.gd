extends Node

class_name StatePlayer

signal Transition

var character : CharacterBody2D
var playback : AnimationNodeStateMachinePlayback
@export var stateMachine : Node

#Constantes que modifican salto.
const jump_height = 370.0 #Alto del salto,
const jump_peak = 0.45 #Tiempo que toma llegar a lo alto
const jump_fall = 0.30 #Tiempo que toma en caer

#Operaciones necesarias para el salto
var jump_velocity = -((2.0 * jump_height) / jump_peak)
var jump_gravity : float = -((-2.0 * jump_height) / (jump_peak * jump_peak))
var fall_gravity : float = -((-2.0 * jump_height) / (jump_fall * jump_fall))

func state_process(_delta):
	pass
	
func state_input(_event : InputEvent):
	pass

func Enter():
	pass

func Exit():
	pass

#Devuelve gravedad
func get_gravity() -> float:
	return jump_gravity if character.velocity.y < 0.0  else fall_gravity
	
