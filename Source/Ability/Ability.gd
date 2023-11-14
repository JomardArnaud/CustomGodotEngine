class_name Ability
extends Node2D

@onready var info : Dictionary : get = getInfo
@onready var condition : Callable
@onready var actionStart : Callable
@onready var actionEnd : Callable
@onready var cd : Timer : get = getTimerCd
@onready var duration : Timer : get = getTimerDuration

func _process(_delta: float) -> void:
	if condition.call():
		actionStart.call()

func _on_duration_timeout() -> void:
	actionEnd.call()

func init(timeCd : float, timeDuration : float = 0) -> void:
	var timerCd := Timer.new()
	timerCd.one_shot = true
	timerCd.wait_time = timeCd
	if timeDuration != 0:
		var timerDuration := Timer.new()
		timerDuration.one_shot = true
		timerDuration.wait_time = timeDuration
		duration = timerDuration
		add_child(duration)
		duration.connect("timeout", _on_duration_timeout)
	cd = timerCd
	add_child(cd)
	
### setter | getter ###
func setInfo(nInfo: Dictionary) -> Ability:
	info = nInfo
	return self

func setCondition(nCondition: Callable) -> Ability:
	condition = nCondition
	return self

func setActionStart(nAction: Callable) -> Ability:
	actionStart = nAction
	return self
	
func setActionEnd(nAction: Callable) -> Ability:
	actionEnd = nAction
	return self

func setCd(nCd: float) -> Ability:
	cd.wait_time = nCd
	return self

func setDuration(nDuration: float) -> Ability:
	duration.wait_time = nDuration
	return self

func getInfo() -> Dictionary:
	return info

func getTimerCd() -> Timer:
	return cd

func getTimerDuration() -> Timer:
	return duration
