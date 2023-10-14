class_name MovementManager
extends Node2D

@export var inertia : float : set = setInertia, get = getInertia
@export var speed : float : set = setSpeed, get = getSpeed # distance per second
@onready var dir : Vector2 : set = setDir, get = getDir 
@onready var velocity : Vector2 : set = setVelocity, get = getVelocity

func reset_velocity() -> void:
	self.velocity = Vector2(0, 0)

func update_velocity(delta: float):
	self.velocity = lerp(self.dir * self.speed, self.velocity, pow(self.inertia / 10, delta));

### all getter | setter ###
func setInertia(nInertia: float):
	inertia = nInertia
	return self
	
func getInertia() -> float:
	return inertia
	
func setSpeed(nSpeed: float):
	speed = nSpeed
	return self
	
func getSpeed() -> float:
	return speed

func setDir(nDir: Vector2):
	dir = nDir
	return self
	
func getDir() -> Vector2:
	return dir

func setVelocity(nVelocity: Vector2):
	velocity = nVelocity
	return self
	
func getVelocity() -> Vector2:
	return velocity
	
	
