class_name DebugHud
extends Control

### TODO ###
# faire un hide/show button
# pourvoir le déplacer

### respect this path in the Main's tree node ###
## => get_node("/root/Main/CanvasDebugHud/RootDebugHud")

@onready var valueContainer : VBoxContainer 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.visible = OS.is_debug_build()

func init() -> void:
	valueContainer = $MainContainer.find_child("ValueContainer")

func addDebugValueSlider(sliderValues: Dictionary, valueToConnect: Callable):
	var nValueSlider := HSlider.new()
	var nValueLabel := Label.new()
	nValueSlider.min_value = sliderValues.minValue
	nValueSlider.max_value = sliderValues.maxValue
	nValueSlider.step = sliderValues.step
	nValueSlider.value = sliderValues.value
	nValueLabel.text = str(sliderValues.text, sliderValues.value)
	nValueSlider.value_changed.connect(valueToConnect)
	nValueSlider.value_changed.connect(func(value):
		nValueLabel.text = str(sliderValues.text, value))
	valueContainer.add_child(nValueSlider)
	valueContainer.add_child(nValueLabel)
