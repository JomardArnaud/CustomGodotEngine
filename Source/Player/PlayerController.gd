class_name PlayerController
extends CharacterBody2D

@export var speed = 100
@export var inertia = .3
@export var distanceWeapon = 40

@onready var movement : MovementManager
@onready var weaponScene := preload("res://Source/Weapon/Weapon.tscn")
@onready var weapon: Weapon

func _ready():
	self.movement = MovementManager.new()
	self.movement.setSpeed(speed).setInertia(inertia)
	
	weapon = weaponScene.instantiate()
	add_child(weapon)	
	weapon.setDistanceEntity(distanceWeapon).fireRate(0.15)
	tmp_set_slider()
	
func _physics_process(delta):
	get_dir()
	movement.update_velocity(delta)
	self.set_velocity(movement.getVelocity())
	self.move_and_slide()
	weapon.update(self)
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("dash"):
		dash(movement.getDir())
	pass

func get_dir():
	var horizontalDirection = int(Input.is_action_pressed("moveLeft")) * -1 + int(Input.is_action_pressed("moveRight"))
	var verticalDirection = int(Input.is_action_pressed("moveUp")) * -1 + int(Input.is_action_pressed("moveDown"))
	self.movement.setDir(Vector2(horizontalDirection, verticalDirection))

### Ability ###

## Dash ##

var dashInfo = {
	baseSpeed = 0
}

func setDashInfo() -> void:
	dashInfo["baseSpeed"] = movement.getSpeed()
	pass

func dash(dirPlayer: Vector2):
	
	pass

## TPM SLIDER MOUV MANAGER ##
@export var canvasHud: CanvasLayer
@onready var sliderSpeed: HSlider
@onready var textSpeed: Label
@onready var sliderInertia: HSlider
@onready var textInertia: Label

func tmp_set_slider() -> void:
	canvasHud.visible = true
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
