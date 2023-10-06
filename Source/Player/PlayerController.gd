extends CharacterBody2D

@export var speed = 100
@export var inertia = .8
@onready var movement : MovementManager

func _ready():
	print("player ready")
	self.movement = MovementManager.new()
	self.movement.speed = speed
	self.movement.inertia = inertia

func _physics_process(delta):
	get_dir()
	movement.update_velocity(delta)
	self.set_velocity(movement.get_velocity())
	self.move_and_slide()
	
#	mainCamera.position = self.position

func get_dir():
	var horizontalDirection = int(Input.is_action_pressed("moveLeft")) * -1 + int(Input.is_action_pressed("moveRight"))
	var verticalDirection = int(Input.is_action_pressed("moveUp")) * -1 + int(Input.is_action_pressed("moveDown"))
	self.movement.set_direction(Vector2(horizontalDirection, verticalDirection))

