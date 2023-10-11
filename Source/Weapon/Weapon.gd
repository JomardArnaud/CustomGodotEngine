class_name Weapon
extends Node2D

var infoWeapon= {
	distanceEntity = 0.0,
	fireRate = 0.0
}

# which determine the distance between the weapon and the entity
@onready var offsetEntity :
	get:
		return offsetEntity
	set (value):
		offsetEntity = value

@onready var _fireRate : float
@onready var bullet := preload("res://Source/Weapon/Bullet/Bullet.tscn")
@onready var fireTimer = $fireTimer

func update(entity: Node2D) -> void:
	var mousePos = get_global_mouse_position()
	var dirWeapon = (mousePos - entity.get_position()).normalized()
#	self.setRotation(mousePos)
	self.set_position(dirWeapon * offsetEntity)
	if Input.is_action_pressed("shot") && fireTimer.time_left == 0:
		shot()
		fireTimer.start()
	
func shot() -> void:
	print("piou piou piou")
	pass

func fireRate(__fireRate: float):
	_fireRate = __fireRate
	return self
