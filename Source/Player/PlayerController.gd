extends CharacterBody2D

@export var speed = 100
@export var inertia = .8

@onready var movement : MovementManager
@onready var weaponScene := preload("res://Source/Weapon/Weapon.tscn")
@onready var weapon: Weapon

func _ready():
	print("player ready")
	self.movement = MovementManager.new()
	self.movement.speed = speed
	self.movement.inertia = inertia
	weapon = weaponScene.instantiate()
	add_child(weapon)	
	weapon.set("offsetEntity", 50)
	weapon.fireRate(0.5)
	tmp_set_slider()
	
func _physics_process(delta):
	get_dir()
	movement.update_velocity(delta)
	self.set_velocity(movement.get_velocity())
	self.move_and_slide()
	weapon.update(self)
#	mainCamera.position = self.position

func get_dir():
	var horizontalDirection = int(Input.is_action_pressed("moveLeft")) * -1 + int(Input.is_action_pressed("moveRight"))
	var verticalDirection = int(Input.is_action_pressed("moveUp")) * -1 + int(Input.is_action_pressed("moveDown"))
	self.movement.set_direction(Vector2(horizontalDirection, verticalDirection))


## TPM SLIDER MOUV MANAGER ##
@export var sliderSpeed: HSlider
@export var sliderInertia: HSlider

func tmp_set_slider() -> void:
	sliderSpeed.min_value = 25
	sliderSpeed.max_value = 300
	sliderSpeed.step = 1
	sliderSpeed.value = speed
	sliderSpeed.value_changed.connect(func(value): self.movement.speed = value)
	sliderInertia.min_value = 0
	sliderInertia.max_value = 1
	sliderInertia.step = .025
	sliderInertia.value = inertia
	sliderInertia.value_changed.connect(func(nInertia): self.movement.inertia = nInertia)
