extends Node2D

@onready var movement : MovementManager

func _ready() -> void:
	self.movement = MovementManager.new()
	self.movement.inertia = 0
	z_index = 30
	
func _process(delta: float) -> void:
	self.movement.update_velocity(delta)
	self.global_position += self.movement.velocity
	pass

func posOrigin(nPos: Vector2):
	self.global_position = nPos
	return self

func dir(nDir: Vector2):
	self.movement.set_direction(nDir)
	return self

func speed(nSpeed: float):
	self.movement.speed = nSpeed
	return self
