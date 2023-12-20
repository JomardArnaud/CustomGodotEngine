class_name HitAnim
extends Control

@export var speed: float = 5
@export var distanceEntityRange := Vector2(-50, 50) 
# maybe latter
# @export var fadeSpeed: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# set a random coordonate from the distanceEntityRange to add from the collision impact
	pass # Replace with function body.

func _process(delta: float) -> void:
	position.y += speed * delta

# must be call just after the instance of the HitAnim
func setDmgOutput(nDmg: float) -> void:
	$Label.text = str(nDmg)

func _on_duration_timeout() -> void:
	queue_free()
