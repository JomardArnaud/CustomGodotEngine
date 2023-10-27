class_name Abilty
extends Node2D

@onready var info : Dictionary : get = getInfo
@onready var condition : Callable
@onready var actionStart : Callable
@onready var actionEnd : Callable
@onready var cd : Timer : get = getCd
@onready var duration : Timer : get = getDuration

func _process(delta: float) -> void:
	if condition.call(): 
		actionStart.call()

func _on_duration_timeout() -> void:
	actionEnd.call()

func init() -> void:
	cd = $Couldown
	duration = $Duration
	
### setter | getter ###
func setInfo(nInfo: Dictionary) -> Abilty:
	info = nInfo
	return self

func setCondition(nCondition: Callable) -> Abilty:
	print(nCondition)
	condition = nCondition
	return self

func setActionStart(nAction: Callable) -> Abilty:
	actionStart = nAction
	actionStart.call()
	return self
	
func setActionEnd(nAction: Callable) -> Abilty:
	actionEnd = nAction
	return self

func setCd(nCd: float) -> Abilty:
	cd.wait_time = nCd
	return self

func setDuration(nDuration: float) -> Abilty:
	duration.wait_time = nDuration
	return self

func getInfo() -> Dictionary:
	return info

func getCd() -> Timer:
	return cd

func getDuration() -> Timer:
	return duration
