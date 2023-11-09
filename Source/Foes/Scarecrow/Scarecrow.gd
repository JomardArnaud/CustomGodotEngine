extends Node2D

@export var maxHP: int = 100

@onready var hp : HealthManager
@onready var hpBar := $HpBarRoot/HpBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hp = HealthManager.new()
	hp.setMaxHealth(maxHP).setHealth(maxHP)
	hpBar.value = hp.getHealth()
	hp.connect("healthChanged", onHealthChanged)
	hp.connect("healthDropZero", onHealthDropZero)
	
func onHealthChanged(nHP: int) -> void:
	hpBar.value = nHP

func onHealthDropZero() -> void:
	hp.setHealth(maxHP)

func getHP() -> HealthManager:
	return self.hp
