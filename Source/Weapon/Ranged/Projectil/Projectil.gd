class_name Bullet
extends Node2D

@onready var movement : MovementManager

### tmp until dmgObject
@onready var dmg : int = 5

func _ready() -> void:
	movement = MovementManager.new()
	movement.setInertia(0)
	add_to_group("bullets")
	
func _process(delta: float) -> void:
	movement.update_velocity(delta)
	global_position += movement.getVelocity()

func setPosOrigin(nPos: Vector2) -> Bullet:
	global_position = nPos
	return self

func setDir(nDir: Vector2) -> Bullet:
	movement.setDir(nDir)
	return self

func setSpeed(nSpeed: float) -> Bullet:
	movement.setSpeed(nSpeed)
	return self

func _on_area_2d_body_entered(body: Node2D) -> void:
	if !(body is Weapon || body is PlayerController):
		destroy()

func _on_area_2d_area_entered(area: Area2D) -> void:
	var areaParent := area.get_parent() 
	if "hp" in areaParent:
		Damage.addDmg(areaParent, 5)
	if !(areaParent is Bullet):
		destroy()

func destroy() -> void:
	queue_free()
