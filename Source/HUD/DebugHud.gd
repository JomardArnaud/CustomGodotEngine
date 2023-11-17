class_name DebugHud
extends CanvasLayer

### TODO ###
# faire un hide/show button
# pourvoir le déplacer

### respect this path in the Main's tree node ###
## => get_node("/root/Main/DebugHud/ValuesPanel")

@onready var valuesContainer : Control 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = OS.is_debug_build()

func init() -> void:
	valuesContainer = find_child("ValuesContainer")

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
	valuesContainer.add_child(nValueSlider)
	valuesContainer.add_child(nValueLabel)
