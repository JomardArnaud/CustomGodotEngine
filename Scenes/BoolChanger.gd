extends HBoxContainer

@export var entityToChange : Node2D
#put this with a capital letter first
@export var proprietyToChange : String

@onready var label := $Label
@onready var numLine := $NumLineEdit

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.