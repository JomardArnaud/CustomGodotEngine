class_name NumLineEdit
extends LineEdit

@onready var numRegex := RegEx.new()
@onready var separatorRegex := RegEx.new()

func _ready() -> void:
	numRegex.compile("[.,\\d]")
	self.text_changed.connect(onTextChanged)

func onTextChanged(nText: String):
	var tmpFinal = ""
	var matchText = numRegex.search_all(nText)
	if matchText:
		for i in range(0, matchText.size()):
			tmpFinal += matchText[i].get_string()
	text = tmpFinal
	set_caret_column(text.length())
