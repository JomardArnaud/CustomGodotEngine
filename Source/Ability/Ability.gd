class_name Abilty
extends Node2D

@onready var info : Dictionary
@onready var condition : Callable
@onready var action : Callable
@onready var cd := $Couldown : get = getCd
@onready var duration := $Duration : get = getDuration

func _input(event: InputEvent) -> void:
	if condition.call(): 
		action.call()	
	pass

### setter | getter ###
func setInfo(nInfo: Dictionary) -> Abilty:
	info = nInfo
	return self

func setCondition(nCondition: Callable) -> Abilty:
	condition = nCondition
	return self

func setAction(nAction: Callable) -> Abilty:
	action = nAction
	return self

func setCd(nCd: float) -> Abilty:
	cd.wait_time = nCd
	return self

func setDuration(nDuration: float) -> Abilty:
	duration.wait_time = nDuration
	return self

func getCd() -> Timer:
	return cd

func getDuration() -> Timer:
	return duration
