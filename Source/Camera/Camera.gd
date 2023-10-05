extends Camera2D

@export var speedCamera := 1.0 
@export var focusEntity: Node2D
# in percent 100% for no rect at all, which mean the camera will always move when the mouse move
@export var offsetLimitViewport := 20

@onready var focusOnEntityDoubleTap = 0

const smooth_lean := 10.0
const scale_lean  := 0.2

func lean_camera_towards_mouse_(delta:float) -> void:
	var mouse_position := get_global_mouse_position()
	
	#var direction_to_mouse := (mouse_position - position).normalized()
	#var distance_to_mouse :=  mouse_position.distance_to(position)
	#var lean := direction_to_mouse * distance_to_mouse * scale_lean
	var lean := (mouse_position - position) * scale_lean
	# offset = lean <--- this would work fine but we lerp it to make it smoother
	offset = lerp(offset, lean, delta * smooth_lean)
	
func match_player_position_() -> void:
	position = get_node("../player").position

func _process(delta) -> void:
	lean_camera_towards_mouse_(delta)
	self.position = focusEntity.position
	
func _input(event: InputEvent) -> void:
	#doucleTap for re focus on player
	if event.is_action_pressed("focusOnPlayer"):
		pass

# get the distance betwee
