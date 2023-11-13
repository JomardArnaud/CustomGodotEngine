class_name BaseAttack
extends Polygon2D

# It will be set directly on editor not with the code (Cause of placing the polygon)

@export var dmg := 15.0 : get = getDmg
# Duration of the attack will have a attack hitbox
@export var durationActif := 0.5

@onready var hitbox : Area2D
@onready var timerDurationActif : Timer = $Duration

func _ready():
	set_poly(self.polygon)
	timerDurationActif.wait_time = durationActif
	timerDurationActif.start()

func set_poly(poly: PackedVector2Array)-> void:
	var body = Area2D.new()
	var collision_shape = CollisionPolygon2D.new()
	collision_shape.polygon = poly
	body.add_child(collision_shape)
	self.add_child(body)
	hitbox = body
	hitbox.area_entered.connect(_on_area_2d_area_entered)

func getDmg() -> float:
	return dmg

func getDurationActif() -> Timer:
	return timerDurationActif

func getHitbox() -> Area2D:
	return hitbox

func setPosOrigin(nPos: Vector2) -> BaseAttack:
	global_position = nPos
	return self

func _on_duration_timeout() -> void:
	destroy()

func _on_area_2d_area_entered(area: Area2D) -> void:
	var areaParent := area.get_parent() 
	if "hp" in areaParent:
		print("???")
		areaParent.hp.takeDamage(dmg)
	# if !(areaParent is BaseAttack):
	# 	self.queue_free()

func destroy() -> void:
	print("bye by")
	self.queue_free()