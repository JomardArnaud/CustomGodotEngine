class_name Abilty
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

func init(timeCd : float, timeDuration : float) -> void:
	var timerCd := Timer.new()
	timerCd.one_shot = true
	timerCd.wait_time = timeCd
	var timerDuration := Timer.new()
	timerDuration.one_shot = true
	timerDuration.wait_time = timeDuration
	cd = timerCd
	self.add_child(cd)
	duration = timerDuration
	self.add_child(duration)
	print(timeCd, cd.wait_time)
	duration.connect("timeout", _on_duration_timeout)
	
### setter | getter ###
func setInfo(nInfo: Dictionary) -> Abilty:
	info = nInfo
	return self

func setCondition(nCondition: Callable) -> Abilty:
	condition = nCondition
	return self

func setActionStart(nAction: Callable) -> Abilty:
	actionStart = nAction
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

func getTimerCd() -> Timer:
	return cd

func getTimerDuration() -> Timer:
	return duration
