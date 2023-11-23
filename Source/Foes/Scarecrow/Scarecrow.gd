extends Node2D

@export var maxHP: int = 100
@onready var hpBar := $HpBarRoot

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hp.healthChanged.connect(onHealthChanged)
	hp.healthDropZero.connect(onHealthDropZero)
	
func onHealthChanged(nHP: int) -> void:
	hpBar.value = nHP

func onHealthDropZero() -> void:
	hp.setHealth(maxHP)

func getHP() -> HealthManager:
	return hp
