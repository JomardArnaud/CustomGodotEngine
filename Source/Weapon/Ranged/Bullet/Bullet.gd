class_name Bullet
extends Node2D

@onready var movement : MovementManager

### tmp until dmgObject
@onready var dmg : int = 5

func _ready() -> void:
	self.movement = MovementManager.new()
	self.movement.setInertia(0)
	add_to_group("bullets")
	
func _process(delta: float) -> void:
	self.movement.update_velocity(delta)
	self.global_position += self.movement.getVelocity()

func posOrigin(nPos: Vector2) -> Bullet:
	self.global_position = nPos
	return self

func setDir(nDir: Vector2) -> Bullet:
	self.movement.setDir(nDir)
	return self

func setSpeed(nSpeed: float) -> Bullet:
	self.movement.setSpeed(nSpeed)
	return self

func _on_area_2d_body_entered(body: Node2D) -> void:
	if !(body is Weapon || body is PlayerController):
		self.queue_free()

func _on_area_2d_area_entered(area: Area2D) -> void:
	var areaParent := area.get_parent() 
	if "hp" in areaParent:
		areaParent.hp.takeDamage(dmg)
	if !(areaParent is Bullet):
		self.queue_free()

func destroy() -> void:
	self.queue_free()
