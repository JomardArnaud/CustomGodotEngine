class_name PlayerController
extends CharacterBody2D

@export var speed = 550
@export var inertia = .35
@export var distanceWeapon = 40

@onready var movement : MovementManager
@onready var RangedWeaponScene := load("res://Source/Weapon/Ranged/RangedWeapon.tscn")
@onready var weapon : RangedWeapon
@onready var debugHud = get_node("/root/Main/CanvasDebugHud/RootDebugHud")
 
func _ready():
	self.movement = MovementManager.new()
	self.movement.setSpeed(speed).setInertia(inertia)
	weapon = RangedWeaponScene.instantiate()
	weapon.init(self, Callable())
	weapon.setDistanceEntity(distanceWeapon).setFireRate(0.15)
	add_child(weapon)
	## abilities ##
	setDash()
	tmpSetSlider() # for test value directly on running time 
	
func _physics_process(delta):
	setDir()
	movement.update_velocity(delta)
	self.set_velocity(movement.getVelocity())
	self.move_and_slide()
	weapon.update()

func setDir():
	var horizontalDirection = int(Input.is_action_pressed("moveLeft")) * -1 + int(Input.is_action_pressed("moveRight"))
	var verticalDirection = int(Input.is_action_pressed("moveUp")) * -1 + int(Input.is_action_pressed("moveDown"))
	self.movement.setDir(Vector2(horizontalDirection, verticalDirection))

### Ability ###

## Dash ##

@export_category("Abilities")
@export var dashCD : float
@export var dashDuration : float
@export var dashPower : float = 4.5
@onready var timerDash := $DashCdTimer
@onready var timerDashing := $DashingTimer

func setDash() -> void:
	var dash = Abilty.new()
	dash.init(dashCD, dashDuration)
	dash.setInfo(InfoAbility.createDashInfo(movement.getSpeed(), dashPower))
	dash.setCondition(InfoAbility.basicTimerCondition.bind("dash", dash.getTimerCd()))
	dash.setActionStart(InfoAbility.dashActionStart.bind(movement, dash))
	dash.setActionEnd(InfoAbility.dashActionEnd.bind(movement, dash))
	add_child(dash)
	
## TPM SLIDER MOUV MANAGER ##

func tmpSetSlider() -> void:
	debugHud.init()
	debugHud.addDebugValueSlider({
		minValue = movement.getSpeed() / 10,
		maxValue =  movement.getSpeed() * 10,
		step = movement.getSpeed() / 500,
		value = movement.getSpeed(),
		text = "Speed = "
	}, func(nSpeed):
		self.movement.setSpeed(nSpeed))
	debugHud.addDebugValueSlider({
		minValue = 0,
		maxValue =  1,
		step = 0.025,
		value = inertia,
		text = "Inertia = "
	}, func(nInertia):
		self.movement.setInertia(nInertia))
