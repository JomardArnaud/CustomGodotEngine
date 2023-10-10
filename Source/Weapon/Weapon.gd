class_name Weapon
extends Node2D

# texture of the weapon
#@export var texture: Texture2D
# which determine the distance between the weapon and the entity
@onready var offsetEntity :
	get:
		return offsetEntity
	set (value):
		offsetEntity = value
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func update(entity: Node2D) -> void:
	var mousePos = get_global_mouse_position()
	var dirWeapon = (mousePos - entity.get_position()).normalized()
	self.setRotation(mousePos)
	self.set_position(dirWeapon * offsetEntity)
	pass

func setRotation(mousePosition: Vector2) -> void:
#	self.look_at(mousePosition)
#	self.rotate(deg_to_rad(180))
	pass
	
#func setDirWeapon() -> Vector2:
#	var dirWeapon: Vector2
#	return dirWeapon
