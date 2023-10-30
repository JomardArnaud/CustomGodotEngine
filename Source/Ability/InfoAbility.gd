class_name InfoAbility
extends Object
#maybe i will not put that all these info in only one file but more likely for the specific one put direct into their script 


### Abilities's dictionary ###

## Dash ##

static var dashInfo = {
	baseSpeed = 0, # buffer of the base speed's entity
#	cd = 1, # dash couldown
#	duration = 0.1, # dashing's duration
	power = 4.5 # the ratio which will be multiple to the entity's speed 
}

static func createDashInfo(baseSpeed : float, power: float) -> Dictionary:
	var dest = dashInfo.duplicate()
	dest["baseSpeed"] = baseSpeed
	dest["power"] = power
	return dest

### Abilities's callable ###

## Dash ##

static func basicTimerCondition(nameAction: String, timerCd: Timer) -> bool:
	return Input.is_action_pressed(nameAction) && timerCd.time_left == 0

static func dashActionStart(entityMovement: MovementManager, dashAbility: Abilty) -> void:
	entityMovement.lockDir(true)
	dashAbility.getInfo()["baseSpeed"] = entityMovement.getSpeed()
	entityMovement.setSpeed(dashAbility.getInfo()["baseSpeed"] * dashAbility.getInfo()["power"])
	dashAbility.getTimerDuration().start()
	dashAbility.getTimerCd().start()
	
static func dashActionEnd(entityMovement: MovementManager, dashAbility: Abilty) -> void:
	entityMovement.lockDir(false)
	entityMovement.setSpeed(dashAbility.getInfo()["baseSpeed"])
