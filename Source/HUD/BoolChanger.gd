extends MarginContainer

@export var entityToChange : Node2D
@export var proprietyToChange : String
#info which will be display by the Label
@export var infoText : String

@onready var label := $ValueContainer/Label

func _ready() -> void:
	if entityToChange != null:
		label.text = infoText + ""
	else:
		push_error("no entity was found !")

func _on_check_button_toggled(button_pressed:bool) -> void:
	entityToChange.set(proprietyToChange, button_pressed)
