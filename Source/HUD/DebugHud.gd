class_name DebugHud
extends CanvasLayer

@onready var valuesContainer : Control
@onready var mainPanel : Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = OS.is_debug_build()
	mainPanel = find_child("ValuesContainer")

func _on_check_button_toggled(button_pressed: bool) -> void:
	mainPanel.visible = button_pressed

func _on_control_focus_exited() -> void:
	print("coucou")
	get_tree().paused = true


func _on_control_focus_entered() -> void:
	print("goodbye")
	get_tree().paused = false
