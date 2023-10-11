extends Node2D

var BulletInfo = {
	posOrigin = Vector2(),
	dir = Vector2(),
	speed = Vector2()
}

@onready var movement : MovementManager

# Called when the node enters the scene tree for the first time.
func _spawn(infoSpawn: Dictionary) -> void:
	self.movement = MovementManager.new()
	self.movement.speed = infoSpawn["speed"]
	self.movement.dir = infoSpawn["dir"]
	self.position = infoSpawn["posOrigin"]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
