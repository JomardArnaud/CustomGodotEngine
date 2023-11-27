extends Node2D

@onready var health := $Health
@onready var respawnTimer := $RespawnTimer
@onready var parent := get_parent()

func onHealthDropZero() -> void:
	respawnTimer.start()
	respawnTimer.reparent(parent)
	parent.remove_child(self)

func _on_respawn_timer_timeout() -> void:
	respawnTimer.reparent(self)
	parent.add_child(self)
	health.info.setHealth(health.info.getMaxHealth())
