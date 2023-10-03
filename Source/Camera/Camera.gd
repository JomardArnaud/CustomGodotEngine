extends Camera2D

@export var speedCamera := 1.0 
@export var focusEntity: Node2D
# in percent 100% for no rect at all, which mean the camera will always move when the mouse move
@export var offsetLimitViewport := 20

@onready var focusOnEntityDoubleTap = 0
@onready var limitMouse: Vector4

func _ready() -> void:
	print("Camera ready")
	var viewportSize := get_viewport_rect().size
#Vector2(rectViewport.position.x + viewportSize.x * offsetLimitViewport / 200,
#		rectViewport.position.y + viewportSize.y * offsetLimitViewport / 200),
	limitMouse = Vector4(viewportSize.x * offsetLimitViewport / 200,
		viewportSize.y * offsetLimitViewport / 200,
		viewportSize.x - viewportSize.x * offsetLimitViewport / 200,
		viewportSize.y - viewportSize.y * offsetLimitViewport / 200)
	
func _process(delta: float) -> void:
	pass
	self.position = focusEntity.position
#	MyUtils.addDebugLines(self, [Vector2(self.position.x, self.position.y),
#	Vector2(self.position.x + limitMouse.shape.size.x, self.position.y),
#	Vector2(self.position.x + limitMouse.shape.size.x, self.position.y + limitMouse.shape.size.y),
#	Vector2(self.position.x, self.position.y + limitMouse.shape.size.y)])
#	print([Vector2(self.position.x, self.position.y),
#	Vector2(self.position.x + limitMouse.shape.size.x, self.position.y),
#	Vector2(self.position.x + limitMouse.shape.size.x, self.position.y + limitMouse.shape.size.y),
#	Vector2(self.position.x, self.position.y + limitMouse.shape.size.y)])
#	if Geometry2D.(get_viewport().get_mouse_position(), limitMouse.shape.polygon) != true:
#		print("outside")
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("focusOnPlayer"):
		pass

# get the distance betwee
