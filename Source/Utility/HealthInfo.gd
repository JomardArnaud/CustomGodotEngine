class_name HealthInfo
extends Resource

@export var visibleHpBar := true
@export var health : int : set = setHealth, get = getHealth
@export var maxHealth : int : set = setMaxHealth, get = getMaxHealth

signal healthChanged
signal healthDropZero

func heal(nHeal: int) -> void:
	health = clampi(health + nHeal, health, maxHealth)
	emit_signal("healthChanged", health)

func takeDamage(damage: int) -> void:
	health = clampi(health - damage, 0, health)
	emit_signal("healthChanged", health)
	if health == 0:
		emit_signal("healthDropZero")

func setHealth(nHealth: int) -> HealthInfo:
	health = clampi(nHealth, 0, maxHealth)
	if health == 0:
		emit_signal("healthDropZero")
	return self
	
func getHealth() -> int:
	return health

func setMaxHealth(nMaxHealth: int) -> HealthInfo:
	maxHealth = nMaxHealth
	return self
	
func getMaxHealth() -> int:
	return maxHealth