class_name HealthManager
extends Control

@export var info : HealthInfo

func _ready() -> void:
	self.visible = info.visibleHpBar
	pass
