class_name PlayerController
extends MovementBody2D

@onready var mainWeapon := $Smg
@onready var debugHud : Node
@onready var tmpNode : Node2D : set = setTmpNode

func _ready():
	## abilities ##
	addAbilities()
	
func _process(_delta: float) -> void:
	if (Input.is_action_pressed("attack") && mainWeapon.weaponIsUp()):
		mainWeapon.attack()

func updateDir() -> void:
	var horizontalDirection = int(Input.is_action_pressed("moveLeft")) * -1 + int(Input.is_action_pressed("moveRight"))
	var verticalDirection = int(Input.is_action_pressed("moveUp")) * -1 + int(Input.is_action_pressed("moveDown"))
	setDir(Vector2(horizontalDirection, verticalDirection))

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
@export var dashPower : float = 800
@onready var timerDash := $DashCdTimer
@onready var timerDashing := $DashingTimer

func setDash() -> void:
	var dash = Ability.new()
	dash.init(dashCD, dashDuration)
	dash.setInfo(InfoAbility.createDashInfo(getSpeed(), dashPower))
	dash.setCondition(InfoAbility.basicTimerCondition.bind("dash", dash.getTimerCd()))
	dash.setActionStart(InfoAbility.dashActionStart.bind(self, dash))
	dash.setActionEnd(InfoAbility.dashActionEnd.bind(self, dash))
	add_child(dash)
	
## TPM SLIDER MOUV MANAGER ##

func tmpSetSlider() -> void:
	debugHud.init()
	debugHud.addDebugValueSlider({
		minValue = getSpeed() / 10,
		maxValue =  getSpeed() * 10,
		step = getSpeed() / 500,
		value = getSpeed(),
		text = "Speed = "
	}, func(nSpeed):
		setSpeed(nSpeed))
	debugHud.addDebugValueSlider({
		minValue = 0,
		maxValue =  1,
		step = 0.025,
		value = inertia,
		text = "Inertia = "
	}, func(nInertia):
		setInertia(nInertia))

func _on_main_ready() -> void:
	debugHud = get_node("/root/Main/DebugHud/")
	tmpSetSlider() # for test value directly on running time 
