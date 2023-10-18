class_name HealthManager
extends Object

signal healthChanged

var health : int : set = setHealth, get = getHealth
var maxHealth : int : set = setMaxHealth, get = getMaxHealth

func heal(nHeal: int) -> void:
	health = clampi(health + nHeal, health, maxHealth)
	emit_signal("healthChanged", health)

func takeDamage(damage: int) -> void:
	health = clampi(health - damage, 0, health)
	emit_signal("healthChanged", health)

func setHealth(nHealth: int):
	health = clampi(nHealth, 0, maxHealth)
	return self
	
func getHealth() -> int:
	return health

func setMaxHealth(nMaxHealth: int):
	maxHealth = nMaxHealth
	return self
	
func getMaxHealth() -> int:
	return maxHealth
