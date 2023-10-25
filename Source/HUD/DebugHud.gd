class_name DebugHud
extends Control

@onready var valueContainer : VBoxContainer
 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.visible = OS.is_debug_build()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func init() -> void:
	valueContainer = $MainContainer/VBoxContainer/ValueContainer

func addDebugSlider(sliderValues: Dictionary, nodeToConect: Node, valueToConnect: Callable):
	var nValueSlider := HSlider.new()
	var nValueLabel := Label.new()
	nValueSlider.min_value = sliderValues["minValue"]
	nValueSlider.max_value = sliderValues["maxValue"]
	nValueSlider.step = sliderValues["step"]
	nValueSlider.value = sliderValues["value"]
	nValueLabel.text = str("Speed = ", sliderValues["value"])
	nValueSlider.value_changed.connect(valueToConnect)
	nValueSlider.value_changed.connect(func(value):
		nValueLabel.text = str("Speed = ", value))
	valueContainer.add_child(nValueSlider)
	valueContainer.add_child(nValueLabel)
	pass
