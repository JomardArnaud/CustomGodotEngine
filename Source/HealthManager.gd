class_name HealthManager
extends Object

## add like this in the node => 
## var hp : healthManager
## a constant name hp for ing able to do " if "hp" in collisionParants "

signal healthChanged
signal healthDropZero

var health : int : set = setHealth, get = getHealth
var maxHealth : int : set = setMaxHealth, get = getMaxHealth

func heal(nHeal: int) -> void:
	health = clampi(health + nHeal, health, maxHealth)
	emit_signal("healthChanged", health)

func takeDamage(damage: int) -> void:
	health = clampi(health - damage, 0, health)
	emit_signal("healthChanged", health)
	if health == 0:
		emit_signal("healthDropZero")

func setHealth(nHealth: int) -> HealthManager:
	health = clampi(nHealth, 0, maxHealth)
	if health == 0:
		emit_signal("healthDropZero")
	return self
	
func getHealth() -> int:
	return health

func setMaxHealth(nMaxHealth: int) -> HealthManager:
	maxHealth = nMaxHealth
	return self
	
func getMaxHealth() -> int:
	return maxHealth
