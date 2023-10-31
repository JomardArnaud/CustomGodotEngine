class_name Weapon
extends Node2D

@onready var dirWeapon: Vector2 : get = getDir
@onready var distanceEntity : float : set = setDistanceEntity
@onready var timerAttack : Timer
@onready var attack : Callable
@onready var holder : Node2D

func init(nHolder: Node2D, nAttack: Callable) -> void:
	timerAttack = Timer.new()
	timerAttack.one_shot = true
	add_child(timerAttack)
	attack = nAttack
	holder = nHolder
	
func update() -> void:
	var mousePos = get_global_mouse_position()
	dirWeapon = (mousePos - holder.get_global_position()).normalized()
	self.set_position(dirWeapon * distanceEntity)
	if Input.is_action_pressed("attack") && timerAttack.time_left == 0:
		#need to change that be attack for weapon handle both ranged and close with composition
		attack.call()
		timerAttack.start()

func setDistanceEntity(nDistance: float) -> Weapon:
	distanceEntity = nDistance
	return self

func setFireRate(nFireRate: float) -> Weapon:
	timerAttack.wait_time = nFireRate
	return self

func getDir() -> Vector2:
	return dirWeapon
