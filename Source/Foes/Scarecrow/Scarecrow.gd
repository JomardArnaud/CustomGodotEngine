extends Node2D

@onready var health := $Health

func onHealthDropZero() -> void:
	health.info.setHealth(health.info.getMaxHealth())
