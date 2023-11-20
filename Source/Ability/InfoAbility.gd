class_name InfoAbility
extends Object
#maybe i will not put that all these info in only one file but more likely for the specific one put direct into their script 


### Abilities's dictionary ###

## Dash ##

static var dashInfo = {
	baseSpeed = 0, # buffer of the base speed's entity
	power = 1200 # speed of the entity during dash 
}

static func createDashInfo(baseSpeed : float, power: float) -> Dictionary:
	var dest = dashInfo.duplicate()
	dest.baseSpeed = baseSpeed
	dest.power = power
	return dest

### Abilities's callable ###

## Dash ##

static func basicTimerCondition(nameAction: String, timerCd: Timer) -> bool:
	return Input.is_action_pressed(nameAction) && timerCd.time_left == 0

static func dashActionStart(entity: Node, dashAbility: Ability) -> void:
	var mouse = entity.get_global_mouse_position()
	var entityMovement = entity.get("movement")
	entityMovement.setDir((mouse - entity.get_global_position()).normalized())
	entityMovement.lockDir(true)
	entityMovement.setSpeed(dashAbility.getInfo().power)
	dashAbility.getTimerDuration().start()
	dashAbility.getTimerCd().start()
	
static func dashActionEnd(entityMovement: MovementManager, dashAbility: Ability) -> void:
	entityMovement.lockDir(false)
	entityMovement.setSpeed(dashAbility.getInfo().baseSpeed)
