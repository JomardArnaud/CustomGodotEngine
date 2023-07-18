class_name MovementManager
extends Node

@export var inertia : float
@export var speed : float # distance per second

@onready var dir : Vector2
@onready var velocity : Vector2

func get_direction() -> Vector2:
	return self.dir
	
func get_velocity() -> Vector2:
	return self.velocity

func set_direction(nDir: Vector2) -> void:
	self.dir = nDir

func reset_velocity() -> void:
	self.velocity = Vector2(0, 0)

func update_velocity(delta: float):
	self.velocity = lerp(self.dir * self.speed, self.velocity, pow(self.inertia, delta));
