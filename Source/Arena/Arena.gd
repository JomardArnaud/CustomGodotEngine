@tool
extends Polygon2D

@export var posArena : Vector2
@export var colorArena : Color
@export var colorWall : Color
@export var thicknessBorder : float = 1000

var polygonBorder : PackedVector2Array

# Ok alors faire un algo qui permet de prendre le polygon, et faire un prolongement en partant du centrre du polygon
# vers chaque vertice pour scale le polygon d'origin et produire celui qui sera le border

func _ready():
	if !Engine.is_editor_hint():
		place_border()

func place_border():
	MyUtils.delete_children($Border)
	var center = get_polygon_center()
	$Center.set_position(center)
	# get the projection of each edges of the arena
	for n in self.polygon.size():
		var point = self.polygon[n]
		var next_point = self.polygon[n + 1] if n + 1 < self.polygon.size() else self.polygon[0]
		var collision_shape = CollisionPolygon2D.new()
		collision_shape.polygon = create_border_wall(point, next_point, center)
		$Border.add_child(collision_shape)
		
func _process(delta):
	if Engine.is_editor_hint():
		if Input.is_action_pressed("refreshEditor") && Input.is_key_pressed(KEY_CTRL):
			place_border()
		if Input.is_action_just_pressed("refreshEditor") && Input.is_key_pressed(KEY_ALT):
			MyUtils.delete_children($Border)

func get_polygon_center():
	var center_weight = self.polygon.size()
	var center = Vector2(0,0)
	
	for point in self.polygon:
		center.x += point.x / center_weight
		center.y += point.y / center_weight
	return center

func create_border_wall(edge: Vector2, nextEdge: Vector2, center: Vector2) -> PackedVector2Array:
	var edgeProjection = Vector2(edge.x - center.x, edge.y - center.y).normalized() * thicknessBorder + edge
	var nextEdgeProjetion = Vector2(nextEdge.x - center.x, nextEdge.y - center.y).normalized() * thicknessBorder + nextEdge
	return [edge, edgeProjection, nextEdgeProjetion, nextEdge]
