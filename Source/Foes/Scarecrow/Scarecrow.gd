extends Node2D

@export var maxHP: int = 100

@onready var hp : HealthManager
@onready var hpBar := $HpBarRoot/HpBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	z_index = 50
	hp = HealthManager.new()
	hp.setMaxHealth(maxHP).setHealth(maxHP)
	hpBar.value = hp.getHealth()
	hp.connect("healthChanged", onHealthChanged)
	hp.connect("healthDropZero", onHealthDropZero)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func onHealthChanged(nHP: int) -> void:
	hpBar.value = nHP

func onHealthDropZero() -> void:
	hp.setHealth(maxHP)

func getHP() -> HealthManager:
	return self.hp
