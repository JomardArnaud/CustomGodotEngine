class_name Weapon
extends Node2D

@onready var dirWeapon: Vector2 : get = getDir
@onready var distanceEntity : float : set = setDistanceEntity
@onready var timerAttack : Timer
@onready var attack : Callable

func init(nAttack: Callable) -> void:
	timerAttack = Timer.new()
	timerAttack.one_shot = true
	add_child(timerAttack)
	print(timerAttack)
	attack = nAttack
	
func update(entity: Node2D) -> void:
	var mousePos = get_global_mouse_position()
	dirWeapon = (mousePos - entity.get_global_position()).normalized()
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
