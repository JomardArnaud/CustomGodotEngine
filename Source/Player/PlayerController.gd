class_name PlayerController
extends MovementBody2D

@onready var mainWeapon := $Smg

func _process(_delta: float) -> void:
	if (Input.is_action_pressed("attack") && mainWeapon.weaponIsUp()):
		mainWeapon.attack()
	if (Input.is_action_pressed("dash")):
		emit_signal("dash")

func updateDir() -> void:
	var horizontalDirection = int(Input.is_action_pressed("moveLeft")) * -1 + int(Input.is_action_pressed("moveRight"))
	var verticalDirection = int(Input.is_action_pressed("moveUp")) * -1 + int(Input.is_action_pressed("moveDown"))
	setDir(Vector2(horizontalDirection, verticalDirection))
