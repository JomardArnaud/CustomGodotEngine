class_name Weapon
extends Node2D

# variable for weapon's behaviour
@export var distanceHolder : float

@onready var holder : Node2D
@onready var dirWeapon: Vector2 : get = getDir
@onready var timerAttack := %TimerAttack
@onready var attackFunc : Callable

func _ready() -> void:
	holder = get_parent()

func _process(_delta: float) -> void:
	var mousePos = get_global_mouse_position()
	dirWeapon = (mousePos - holder.get_global_position()).normalized()
	set_position(dirWeapon * distanceHolder)

#will be call when holder decide (by using signal) and define by inheritance
func attack() -> void:
	if (timerAttack.time_left == 0):
		attackFunc.call()
		timerAttack.start()

func getDir() -> Vector2:
	return dirWeapon

func getPos() -> Vector2:
	return global_position

func getHolder() -> Node2D:
	return holder

func setDistanceHolder(nDistance: float) -> Weapon:
	distanceHolder = nDistance
	return self

func setFireRate(nFireRate: float) -> Weapon:
	timerAttack.wait_time = nFireRate
	return self

func weaponIsUp() -> bool:
	return timerAttack.time_left == 0
