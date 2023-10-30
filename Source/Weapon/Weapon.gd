class_name Weapon
extends Node2D

@onready var dirWeapon: Vector2 : get = getDir
@onready var distanceEntity : float : set = setDistanceEntity
@onready var bulletScene := preload("res://Source/Weapon/Bullet/Bullet.tscn")
@onready var attackTimer : Timer
@onready var tmpNode := get_node("/root/Main/TmpNode")
@onready var attack : Callable

func init(nAttack: Callable) -> void:
	attackTimer = $AttackTimer
	attack = nAttack
	
func update(entity: Node2D) -> void:
	var mousePos = get_global_mouse_position()
	dirWeapon = (mousePos - entity.get_global_position()).normalized()
	self.set_position(dirWeapon * distanceEntity)
	if Input.is_action_pressed("attack") && attackTimer.time_left == 0:
		#need to change that be attack for weapon handle both ranged and close with composition
		attack.call()
		attackTimer.start()
	
func shot() -> void:
#	print(nDir)
	var tmpBullet = bulletScene.instantiate()
	tmpNode.add_child(tmpBullet)
	tmpBullet.posOrigin(self.global_position).setDir(dirWeapon).setSpeed(6)

func setDistanceEntity(nDistance: float) -> Weapon:
	distanceEntity = nDistance
	return self

func setFireRate(nFireRate: float) -> Weapon:
	attackTimer.wait_time = nFireRate
	return self

func getDir() -> Vector2:
	if Input.is_action_pressed("attack") && attackTimer.time_left == 0:
		print(dirWeapon)
	return dirWeapon
