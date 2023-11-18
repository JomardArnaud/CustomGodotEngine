extends AreaScriptedEvent

@export var door: Block2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	setEvent(spawnTheDoor)

func spawnTheDoor(area: Area2D) -> void:
	print("hum")
	var areaParent := area.get_parent() 
	if "hp" in areaParent:
		print("**** BADUM ****")
