class_name PlayerController
extends MovementBody2D

signal rangedAttack

func _input(event: InputEvent) -> void:
	if (event.is_action_pressed("rangedAttack")):
		emit_signal("rangedAttack", true)
	if (event.is_action_released("rangedAttack")):
		emit_signal("rangedAttack", false)
	if (event.is_action("dash")):
		emit_signal("dash")
	# if (event.button_index == MOUSE_BUTTON_WHEEL_UP):
	# 	print("up")

func updateDir() -> void:
	var horizontalDirection = int(Input.is_action_pressed("moveLeft")) * -1 + int(Input.is_action_pressed("moveRight"))
	var verticalDirection = int(Input.is_action_pressed("moveUp")) * -1 + int(Input.is_action_pressed("moveDown"))
	setDir(Vector2(horizontalDirection, verticalDirection))
