@tool
extends Node2D

## to do 
# add the possibility to add input event with modifier key

#put only physical_key
var input_to_add = {
	"quitGame": KEY_ESCAPE,
	# editor part
	"refreshEditor": KEY_G,
	"clearDebug": KEY_D,
	# game part
	"focusOnPlayer": KEY_Y,
	"showDebugHud": KEY_A
}
# Called when the node enters the scene tree for the first time.
func _ready():
	for keyEvent in input_to_add:
		var ev = InputEventKey.new()
		ev.physical_keycode = input_to_add[keyEvent]
		InputMap.add_action(keyEvent)
		InputMap.action_add_event(keyEvent, ev)
		print(keyEvent)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event):
	if not Engine.is_editor_hint():
		if (event.is_action_pressed("quitGame")):
			get_tree().quit()
			
