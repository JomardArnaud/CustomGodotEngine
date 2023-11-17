extends Node2D

@export var maxHP: int = 100

@onready var hp : HealthManager
@onready var hpBar := $HpBarRoot/HpBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hp = HealthManager.new()
	hp.setMaxHealth(maxHP).setHealth(maxHP)
	hpBar.value = hp.getHealth()
	hp.healthChanged.connect(onHealthChanged)
	hp.healthDropZero.connect(onHealthDropZero)
	
func onHealthChanged(nHP: int) -> void:
	hpBar.value = nHP

func onHealthDropZero() -> void:
	hp.setHealth(maxHP)

func getHP() -> HealthManager:
	return hp
