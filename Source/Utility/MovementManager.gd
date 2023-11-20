class_name MovementManager
extends Object

@export var inertia : float : set = setInertia, get = getInertia
@export var speed : float : set = setSpeed, get = getSpeed # distance per second
var dir : Vector2 : set = setDir, get = getDir 
var velocity : Vector2 : set = setVelocity, get = getVelocity
var dirLock := false

func resetVelocity() -> void:
	velocity = Vector2(0, 0)

func update_velocity(delta: float):
	if !dirLock :
		velocity = lerp(dir * speed, velocity, pow(inertia / 10, delta));
	else :
		velocity = dir * speed

### all getter | setter ###
func setInertia(nInertia: float) -> MovementManager:
	inertia = nInertia
	return self
	
func getInertia() -> float:
	return inertia
	
func setSpeed(nSpeed: float) -> MovementManager:
	speed = nSpeed
	return self
	
func getSpeed() -> float:
	return speed

func setDir(nDir: Vector2) -> MovementManager:
	if !dirLock:
		dir = nDir
	return self
	
func getDir() -> Vector2:
	return dir

func setVelocity(nVelocity: Vector2) -> MovementManager:
	velocity = nVelocity
	return self
	
func getVelocity() -> Vector2:
	return velocity

func lockDir(nLock: bool) -> MovementManager:
	dirLock = nLock
	return self
