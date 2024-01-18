extends Scene

@onready var pause := false
@onready var debugHud = %DebugHud

# func _ready() -> void:
#     debugHud.visible = pause

func _input(event: InputEvent) -> void:
    if (event.is_action_pressed("pause")):
        pause = !pause
        # debugHud.visible = pause
        get_tree().paused = pause