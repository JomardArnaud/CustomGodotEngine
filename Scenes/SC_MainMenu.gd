extends Scene

func passInfoToNextScene() -> Dictionary:
	var infoNextScene : Dictionary
	infoNextScene["playerPos"] = "hello Scene"
	return infoNextScene

func _on_button_pressed() -> void:
	emit_signal("switchingScene", passInfoToNextScene())
