extends Node2D

signal dashing

@export var info : DashInfo

@onready var holder : MovementBody2D
@onready var cdTimer := $Cd
@onready var durationTimer := $Duration

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	holder = get_parent()
	holder.add_user_signal("dash")
	holder.connect("dash", onDashing)
	cdTimer.wait_time = info.cd
	durationTimer.wait_time = info.duration

func dashActionStart() -> void:
	var mouse = get_global_mouse_position()
	holder.setDir((mouse - holder.get_global_position()).normalized())
	holder.lockDir(true)
	info.baseSpeedHolder = holder.getSpeed()
	holder.setSpeed(info.power)
	durationTimer.start()

func onDashing() -> void:
	if cdTimer.time_left == 0:
		cdTimer.start()
		dashActionStart()

func _on_duration_timeout() -> void:
	holder.lockDir(false)
	holder.resetEnergy()
	holder.setSpeed(info.baseSpeedHolder)

### TPM TEST PURPOSE ###
func getPower() -> float:
	return info.power

func setPower(nPower: float) -> void:
	info.power = nPower

func addPower(nPower: float) -> void:
	info.power += nPower

func getCd() -> float:
	return info.cd
	
func setCd(nCd: float) -> void:
	info.cd = nCd
	cdTimer.wait_time = info.cd

func addCd(nCd: float) -> void:
	info.cd += nCd
	
func getDuration() -> float:
	return info.duration
		
func setDuration(nDuration: float) -> void:
	info.duration = nDuration
	durationTimer.wait_time = info.duration

func addDuration(nDuration: float) -> void:
	info.duration += nDuration
	
