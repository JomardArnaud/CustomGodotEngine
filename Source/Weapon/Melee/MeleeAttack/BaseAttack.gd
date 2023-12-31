class_name BaseAttack
extends APolygon2D

# It will be set directly on editor not with the code (Cause of placing the polygon)

@export var dmg := 15.0 : get = getDmg
# Duration of the attack will have a attack hitbox
@export var durationActif := 0.5

@onready var timerDurationActif : Timer = $Duration

func _ready():
	setAreaFromPolygon()
	hitbox.area_entered.connect(_on_area_2d_area_entered)
	timerDurationActif.wait_time = durationActif
	timerDurationActif.start()

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
		Damage.addDmg(areaParent, dmg)

func destroy() -> void:
	queue_free()
