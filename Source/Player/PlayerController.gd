class_name PlayerController
extends CharacterBody2D

@export var speed = 550
@export var inertia = .35
@export var distanceWeapon = 40

@onready var movement : MovementManager
@onready var weaponScene := preload("res://Source/Weapon/Weapon.tscn")
@onready var weapon : Weapon
@onready var debugHud = get_node("/root/Main/CanvasDebugHud/RootDebugHud")
 
func _ready():
	self.movement = MovementManager.new()
	self.movement.setSpeed(speed).setInertia(inertia)
	weapon = weaponScene.instantiate()
	add_child(weapon)	
	weapon.setDistanceEntity(distanceWeapon).setFireRate(0.15)
	setDashInfo()
	tmp_set_slider()
#	z_index = SpriteManager.ZIndexPlayer
	
func _physics_process(delta):
	get_dir()
	movement.update_velocity(delta)
	self.set_velocity(movement.getVelocity())
	self.move_and_slide()
	weapon.update(self)
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("dash") && timerDash.time_left == 0:
		dash(movement.getDir())
	pass

func get_dir():
	var horizontalDirection = int(Input.is_action_pressed("moveLeft")) * -1 + int(Input.is_action_pressed("moveRight"))
	var verticalDirection = int(Input.is_action_pressed("moveUp")) * -1 + int(Input.is_action_pressed("moveDown"))
	self.movement.setDir(Vector2(horizontalDirection, verticalDirection))

### Ability ###

## Dash ##

var dashInfo = {
	baseSpeed = 0,
	cd = 0,
	duration = 0,
	power = 4.5 # the ratio which will be multiple to the player's speed 
}

@export_category("Abilities")
@export var dashCD : float
@export var dashDuration : float
@onready var timerDash := $DashCdTimer
@onready var timerDashing := $DashingTimer

func setDashInfo() -> void:
	dashInfo["baseSpeed"] = movement.getSpeed()
	dashInfo["cd"] = dashCD
	dashInfo["duration"] = dashDuration
#	dashInfo["power"] = 3
	timerDash.wait_time = dashInfo["cd"]
	timerDashing.wait_time = dashInfo["duration"]
	pass

func dash(dirPlayer: Vector2):
	timerDashing.start()
	movement.lockDir(true)
	dashInfo["baseSpeed"] = movement.getSpeed()
	movement.setSpeed(dashInfo["baseSpeed"] * dashInfo["power"])
	pass

func _on_dashing_timer_timeout() -> void:
	timerDash.start()
	movement.lockDir(false)
	movement.setSpeed(dashInfo["baseSpeed"])
	pass # Replace with function body.

## TPM SLIDER MOUV MANAGER ##

func tmp_set_slider() -> void:
	debugHud.init()
	debugHud.addDebugSlider({
		minValue = movement.getSpeed() / 10,
		maxValue =  movement.getSpeed() * 10,
		step = movement.getSpeed() / 500,
		value = movement.getSpeed(),
		text = "Speed = "
	}, func(nSpeed):
		self.movement.setSpeed(nSpeed))
	debugHud.addDebugSlider({
		minValue = 0,
		maxValue =  1,
		step = 0.025,
		value = inertia,
		text = "Inertia = "
	}, func(nInertia):
		self.movement.setInertia(nInertia))
