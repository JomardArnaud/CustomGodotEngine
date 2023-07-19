@tool
extends Polygon2D

@export var posArena : Vector2
@export var colorArena : Color
@export var colorWall : Color
## make a slider and listen the signal to auto update the border's Arena
@export_range(0, 1000) var thicknessBorder : float = 500

var polygonBorder : PackedVector2Array

# Ok alors faire un algo qui permet de prendre le polygon, et faire un prolongement en partant du centrre du polygon
# vers chaque vertice pour scale le polygon d'origin et produire celui qui sera le border

func _ready():
	if !Engine.is_editor_hint():
		place_border()
	
func _process(delta):
	if Engine.is_editor_hint():
		if Input.is_action_pressed("refreshEditor") && Input.is_key_pressed(KEY_CTRL):
			place_border()
		if Input.is_action_just_pressed("refreshEditor") && Input.is_key_pressed(KEY_ALT):
			MyUtils.delete_children($Border)

## add the collisionShape as child to the scene Border of the Arena
func place_border():
	MyUtils.delete_children(self)
	print("place border")
	for edgeId in range(0, self.polygon.size()):
		var bufferLastEdgeProjection: Vector2
		## if next_edge_concave == true
		## add the point to 
		var debugLine = Line2D.new()
		debugLine.add_point(self.polygon[edgeId])
		debugLine.add_point(line_overlap_polygon(edgeId) + self.polygon[edgeId])
		debugLine.default_color = Color(255, 0, 0, 0.75)
		self.add_child(debugLine)
		print("uwu")
	pass

## check the four cardinal stating to a edge direction lenght thicknnesBorder collider with polygon's Arena and return
## a offset for the projection of the edge 
## taking the current edge id of polygon's Arena
## return Vector2(-1,-1) for error
func line_overlap_polygon(currentEdgeId: int) -> Vector2:
	if (currentEdgeId < 0):
		return Vector2(-1, -1)
	var currentEdge = self.polygon[currentEdgeId]
	var prevEdge = self.polygon[currentEdgeId - 1 if currentEdgeId > 0 else self.polygon.size() - 1]
	var nextEdge = self.polygon[currentEdgeId + 1 if currentEdgeId < self.polygon.size() - 1 else 0]
	var left = Geometry2D.intersect_polyline_with_polygon([currentEdge, Vector2(currentEdge.x - thicknessBorder, currentEdge.y)], self.polygon).size()
	var right = Geometry2D.intersect_polyline_with_polygon([currentEdge, Vector2(currentEdge.x + thicknessBorder, currentEdge.y)], self.polygon).size()
	var up = Geometry2D.intersect_polyline_with_polygon([currentEdge, Vector2(currentEdge.x, currentEdge.y + thicknessBorder)], self.polygon).size()
	var down = Geometry2D.intersect_polyline_with_polygon([currentEdge, Vector2(currentEdge.x, currentEdge.y - thicknessBorder)], self.polygon).size()
	return Vector2(((int(left > 0) - int(right > 0)) * thicknessBorder), ((int(down > 0) - int(up > 0)) * thicknessBorder))

func next_edge_concave(currentEdgeId: int) -> Vector2:
	return Vector2()
