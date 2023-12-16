extends MarginContainer

@export var entityToChange : Node2D
#put this with a capital letter first
@export var proprietyToChange : String
@export var buttonValue : float

@onready var label := $ValueContainer/Label
@onready var numLine := $ValueContainer/NumLineEdit
@onready var setProprity : Callable
@onready var getProprity : Callable
@onready var addProprity : Callable


func _ready() -> void:
	if entityToChange != null:
		label.text = proprietyToChange + " = "
		setProprity = Callable(entityToChange, "set" + proprietyToChange)
		getProprity = Callable(entityToChange, "get" + proprietyToChange)
		addProprity = Callable(entityToChange, "add" + proprietyToChange)
		numLine.text = str(getProprity.call())
	else:
		push_error("no entity was found !")

func _on_minus_button_pressed() -> void:
	addProprity.call(-buttonValue)
	numLine.text = str(getProprity.call())

func _on_plus_button_pressed() -> void:
	addProprity.call(buttonValue)
	numLine.text = str(getProprity.call())

func _on_num_line_edit_text_submitted(nText: String) -> void:
	# well not the best option but it will works for what i need to test now, need to think about the arg thought
	setProprity.call(float(nText))
