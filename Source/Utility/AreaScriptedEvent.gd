class_name AreaScriptedEvent
extends APolygon2D

signal EventDone

# need to thinking about that, it is usefull only if i do static function for scriptedEvent
var infoScript : Dictionary : set = setInfoScript, get = getInfoScript 
var event : Callable : set = setEvent

func _ready() -> void:
	setAreaFromPolygon()
	hitbox.area_entered.connect(_on_area_2d_area_entered)

func _on_area_2d_area_entered(area: Area2D) -> void:
	print("entered")
	event.call(area)
	# , infoScript)

# for later reminder
static func spawnFoes() -> void:
	pass

func getInfoScript() -> Dictionary:
	return infoScript

func setInfoScript(nInfo: Dictionary) -> void:
	infoScript = nInfo

func setEvent(nEvent: Callable) -> void:
	event = nEvent
