class_name Bullet
extends Node2D

@onready var movement : MovementManager

### tmp until dmgObject
@onready var dmg : int = 5

func _ready() -> void:
	self.movement = MovementManager.new()
	self.movement.setInertia(0)
	z_index = 30
	
func _process(delta: float) -> void:
	self.movement.update_velocity(delta)
	self.global_position += self.movement.getVelocity()
	pass

func posOrigin(nPos: Vector2):
	self.global_position = nPos
	return self

func dir(nDir: Vector2):
	self.movement.setDir(nDir)
	return self

func speed(nSpeed: float):
	self.movement.setSpeed(nSpeed)
	return self


func _on_area_2d_body_entered(body: Node2D) -> void:
	if !(body is Weapon || body is PlayerController):
		self.queue_free()


func _on_area_2d_area_entered(area: Area2D) -> void:
	area.get_parent().hp.takeDamage(dmg)
	pass
