extends Node2D
class_name weapon

# texture of the weapon
@export var texture: Texture2D
# which determine the distance between the weapon and the entity
@export var offsetEntity: float
# which entity the weapon is attached to
@export var entity: MovementManager


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var dirWeapon = (get_viewport().get_mouse_position() - entity.get_position()).normalized()
	self.set_position(dirWeapon * offsetEntity)
	pass

func getRotation() -> void:
	pass
	
func setDirWeapon() -> Vector2:
	var dirWeapon: Vector2
	return dirWeapon
