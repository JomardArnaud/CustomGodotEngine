extends Node2D

func _ready() -> void:
	$CanvasDebugHud.visible = OS.is_debug_build()
