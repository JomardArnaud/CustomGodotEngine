class_name HealthInfo
extends Resource

@export var visibleHpBar := true
@export var health : float : set = setHealth, get = getHealth
@export var maxHealth : float : set = setMaxHealth, get = getMaxHealth

signal healthChanged
signal healthDropZero

func heal(nHeal: float) -> void:
	health = clampf(health + nHeal, health, maxHealth)
	emit_signal("healthChanged", health)

func takeDamage(damage: float) -> void:
	health = clampf(health - damage, 0, health)
	emit_signal("healthChanged", health)
	if health == 0:
		emit_signal("healthDropZero")

func setHealth(nHealth: float) -> HealthInfo:
	health = clampf(nHealth, 0, maxHealth)
	if health == 0:
		emit_signal("healthDropZero")
	return self
	
func getHealth() -> float:
	return health

func setMaxHealth(nMaxHealth: float) -> HealthInfo:
	maxHealth = nMaxHealth
	return self
	
func getMaxHealth() -> float:
	return maxHealth
