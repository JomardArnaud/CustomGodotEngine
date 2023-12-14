class_name DebugHud
extends CanvasLayer

@onready var valuesContainer : Control
@onready var mainPanel : Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	mainPanel = find_child("ValuesContainer")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		visible = !visible
		get_tree().paused = visible
