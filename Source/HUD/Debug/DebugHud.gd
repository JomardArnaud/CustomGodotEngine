extends CanvasLayer

@onready var panelHud := $MainContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_check_button_toggled(button_pressed:bool) -> void:
	panelHud.visible = button_pressed
