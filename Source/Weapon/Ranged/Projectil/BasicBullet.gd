class_name Bullet
extends Node2D

@onready var dir : Vector2 : set = setDir, get = getDir
@onready var speed : float : set = setSpeed, get = getSpeed
@onready var dmg : float : set = setDmg, get = getDmg

func _ready() -> void:
	add_to_group("bullets")
	
func _physics_process(delta: float) -> void:
	global_position += dir * speed * delta

func _on_area_2d_body_entered(body: Node2D) -> void:
	if !(body is Weapon || body is PlayerController):
		destroy()

func _on_area_2d_area_entered(area: Area2D) -> void:
	var areaParent := area.get_parent() 
	if "hp" in areaParent:
		Damage.addDmg(areaParent, dmg)
		destroy()

func destroy() -> void:
	queue_free()

func getDir() -> Vector2:
	return dir

func getSpeed() -> float:
	return speed

func getDmg() -> float:
	return dmg

func setDir(nDir: Vector2) -> Bullet:
	dir = nDir
	return self

func setSpeed(nSpeed: float) -> Bullet:
	speed = nSpeed
	return self

func setDmg(nDmg: float) -> Bullet:
	dmg = nDmg
	return self

func setPosOrigin(nPos: Vector2) -> Bullet:
	global_position = nPos
	return self
	
