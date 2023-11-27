extends HBoxContainer

#faudra voir pour le faire de manière automatisée
@export var entityToChange : Node2D

@export var labelValue : String
@export var valueToChange : String
@export var buttonValue : float

@onready var label := $Label
@onready var numLine := $NumLineEdit
@onready var minusButton := $MinusButton
@onready var plusButton := $PlusButton

func _ready() -> void:
	label.text = labelValue
	# put the value of the entity in the numLine
	pass

func _on_minus_button_pressed() -> void:
	pass

func _on_plus_button_pressed() -> void:
	pass