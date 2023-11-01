class_name Weapon
extends Node2D

@onready var dirWeapon: Vector2 : get = getDir
@onready var distanceHolder : float : set = setDistanceHolder
@onready var timerAttack : Timer
@onready var attack : Callable : set = setAttack
@onready var holder : Node2D

func init(nHolder: Node2D) -> void:
	timerAttack = Timer.new()
	timerAttack.one_shot = true
	add_child(timerAttack)
	holder = nHolder
	
func update() -> void:
	var mousePos = get_global_mouse_position()
	dirWeapon = (mousePos - holder.get_global_position()).normalized()
	self.set_position(dirWeapon * distanceHolder)
	if Input.is_action_pressed("attack") && timerAttack.time_left == 0:
		attack.call()
		timerAttack.start()

func setDistanceHolder(nDistance: float) -> Weapon:
	distanceHolder = nDistance
	return self

func setFireRate(nFireRate: float) -> Weapon:
	timerAttack.wait_time = nFireRate
	return self

func getDir() -> Vector2:
	return dirWeapon
	
func setAttack(nAttack: Callable) -> Weapon:
	attack = nAttack
	return self
