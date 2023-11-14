class_name PlayerController
extends CharacterBody2D

@export var speedPlayer = 550
@export var inertia = .35
@export var distanceWeapon = 40

@onready var movement : MovementManager
@onready var RangedWeaponScene := load("res://Source/Weapon/Ranged/RangedWeapon.tscn")
@onready var weapon : RangedWeapon
@onready var MeleeWeaponScene := load("res://Source/Weapon/Melee/MeleeWeapon.tscn")
@onready var meleeWeapon : MeleeWeapon
@onready var debugHud = get_node("/root/Main/CanvasDebugHud/RootDebugHud")
@onready var tmpNode : Node2D : set = setTmpNode

func _ready():
	movement = MovementManager.new()
	movement.setSpeed(speedPlayer).setInertia(inertia)
	# weapon = RangedWeapon.create(self, RangedWeaponScene)
	meleeWeapon = MeleeWeapon.create(self, MeleeWeaponScene)
	## abilities ##
	addAbilities()
	tmpSetSlider() # for test value directly on running time 
	
func _physics_process(delta):
	setDir()
	movement.update_velocity(delta)
	set_velocity(movement.getVelocity())
	move_and_slide()
	meleeWeapon.update()
	# weapon.update()

func setDir() -> void:
	var horizontalDirection = int(Input.is_action_pressed("moveLeft")) * -1 + int(Input.is_action_pressed("moveRight"))
	var verticalDirection = int(Input.is_action_pressed("moveUp")) * -1 + int(Input.is_action_pressed("moveDown"))
	movement.setDir(Vector2(horizontalDirection, verticalDirection))

func setTmpNode(nTmp: Node2D) -> void:
	tmpNode = nTmp

### Ability ###

func addAbilities() -> void:
	var clean = Ability.new()
	clean.init(0.5)
	clean.setCondition(InfoAbility.basicTimerCondition.bind("cleanBullet", clean.getTimerCd()))
	clean.setActionStart(cleanBullet.bind(clean))
	add_child(clean)
	setDash()

## Player ##

func cleanBullet(clean: Ability) -> void:
	get_tree().call_group("bullets", "destroy")
	clean.getTimerCd().start()

## Dash ##

@export_category("Abilities")
@export var dashCD : float
@export var dashDuration : float
@export var dashPower : float = 4.5
@onready var timerDash := $DashCdTimer
@onready var timerDashing := $DashingTimer

func setDash() -> void:
	var dash = Ability.new()
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
		movement.setSpeed(nSpeed))
	debugHud.addDebugValueSlider({
		minValue = 0,
		maxValue =  1,
		step = 0.025,
		value = inertia,
		text = "Inertia = "
	}, func(nInertia):
		movement.setInertia(nInertia))

func _on_main_ready() -> void:
	tmpNode = get_tree().get_root().get_node("Main/TmpNode")
	# weapon.setDistanceHolder(distanceWeapon).setFireRate(0.15).setTmpNode(tmpNode).setAttack(RangedWeapon.shot.bind(weapon))
	meleeWeapon.setDistanceHolder(distanceWeapon).setAttack(MeleeWeapon.hit.bind(meleeWeapon))
