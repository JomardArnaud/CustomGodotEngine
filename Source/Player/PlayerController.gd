class_name PlayerController
extends CharacterBody2D

@export var speed = 100
@export var inertia = .3
@export var distanceWeapon = 40

@onready var movement : MovementManager
@onready var weaponScene := preload("res://Source/Weapon/Weapon.tscn")
@onready var weapon: Weapon

func _ready():
	print("player ready")
	self.movement = MovementManager.new()
	self.movement.setSpeed(speed).setInertia(inertia)
	weapon = weaponScene.instantiate()
	add_child(weapon)	
	weapon.distanceEntity(distanceWeapon).fireRate(0.15)
	tmp_set_slider()
	
func _physics_process(delta):
	get_dir()
	movement.update_velocity(delta)
	self.set_velocity(movement.getVelocity())
	self.move_and_slide()
	weapon.update(self)
	
#	mainCamera.position = self.position

func get_dir():
	var horizontalDirection = int(Input.is_action_pressed("moveLeft")) * -1 + int(Input.is_action_pressed("moveRight"))
	var verticalDirection = int(Input.is_action_pressed("moveUp")) * -1 + int(Input.is_action_pressed("moveDown"))
	self.movement.setDir(Vector2(horizontalDirection, verticalDirection))


## TPM SLIDER MOUV MANAGER ##
@export var canvasHud: CanvasLayer
@onready var sliderSpeed: HSlider
@onready var textSpeed: Label
@onready var sliderInertia: HSlider
@onready var textInertia: Label

func tmp_set_slider() -> void:
	canvasHud.visible = true
	CustomUtils.addDebugSquare(get_tree().root.get_child(0), self.position, Vector2(5, 5), Color(255, 0, 0, 1))
	sliderSpeed = canvasHud.find_child("PlayerSpeed")
	textSpeed = canvasHud.find_child("SpeedText")
	sliderSpeed.min_value = 25
	sliderSpeed.max_value = 300
	sliderSpeed.step = 1
	sliderSpeed.value = speed
	sliderSpeed.value_changed.connect(func(value): 
		self.movement.speed = value
		textSpeed.text = str("Speed = ", value))
	sliderInertia = canvasHud.find_child("PlayerInertia")
	textInertia = canvasHud.find_child("InertiaText")
	sliderInertia.min_value = 0
	sliderInertia.max_value = 1
	sliderInertia.step = .025
	sliderInertia.value = inertia
	sliderInertia.value_changed.connect(func(nInertia): 
		self.movement.inertia = nInertia
		textInertia.text = str("Inertia = ", nInertia))
