class_name Weapon
extends Node2D

@onready var distanceEntity : float : set = setDistanceEntity
@onready var bulletScene := preload("res://Source/Weapon/Bullet/Bullet.tscn")
@onready var fireTimer = $fireTimer
@onready var rootNode := get_tree().root.get_child(0)

func update(entity: Node2D) -> void:
	var mousePos = get_global_mouse_position()
	var dirWeapon = (mousePos - entity.get_global_position()).normalized()
	self.set_position(dirWeapon * distanceEntity)
	if Input.is_action_pressed("shot") && fireTimer.time_left == 0:
		#need to change that be attack for weapon handle both ranged and close with composition
		shot(dirWeapon)
		fireTimer.start()
	
func shot(dirWeapon: Vector2) -> void:
	var tmpBullet = bulletScene.instantiate()
	rootNode.add_child(tmpBullet)
	tmpBullet.posOrigin(self.global_position).dir(dirWeapon).speed(2)
	pass

func setDistanceEntity(nDistance: float) -> Weapon:
	distanceEntity = nDistance
	return self

func fireRate(nFireRate: float) -> Weapon:
	fireTimer.wait_time = nFireRate
	return self
