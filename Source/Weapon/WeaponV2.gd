class_name WeaponV2
extends Node2D

# maybe a way to do that is with ressource
@export var attack : Callable : set = setAttack

# variable for attack's behaviour
@export var dmg : float
@export var attackScene : PackedScene
@export var speed : float # for projectil the speed of deplacement | for melee the speed to launch the attack
@export var distanceHolder : float

# variable for weapon's behaviour
@export var holder : Node2D

@onready var dirWeapon: Vector2 : get = getDir
@onready var timerAttack := %TimerAttack

func _ready() -> void:
	holder = get_parent()

func _process(_delta: float) -> void:
	var mousePos = get_global_mouse_position()
	dirWeapon = (mousePos - holder.get_global_position()).normalized()
	set_position(dirWeapon * distanceHolder)
	if Input.is_action_pressed("attack") && timerAttack.time_left == 0:
		attack.call()
		timerAttack.start()

func getDir() -> Vector2:
	return dirWeapon

func getPos() -> Vector2:
	return global_position

func getHolder() -> Node2D:
	return holder

func setDistanceHolder(nDistance: float) -> WeaponV2:
	distanceHolder = nDistance
	return self

func setFireRate(nFireRate: float) -> WeaponV2:
	timerAttack.wait_time = nFireRate
	return self
	
func setAttack(nAttack: Callable) -> WeaponV2:
	attack = nAttack
	return self
