@tool
extends Polygon2D

### TODO =>
#______________________#
## faire une "class vertexVector avec la pos et la dir

@export var posArena : Vector2
@export var colorArena : Color
@export var colorWall : Color
## make a BETTER slider and listen the signal to auto update the border's Arena
@export_range(1, 250, 0.5) var thicknessBorder = 50

# Ok alors faire un algo qui permet de prendre le polygon, et faire un prolongement en partant du centrre du polygon
# vers chaque vertice pour scale le polygon d'origin et produire celui qui sera le border

func _ready():
	if !Engine.is_editor_hint():
		pass
	
func _process(delta):
	if Engine.is_editor_hint():
		if Input.is_action_pressed("refreshEditor") && Input.is_key_pressed(KEY_CTRL):
			MyUtils.delete_children(self)
			algo()
		if Input.is_action_just_pressed("refreshEditor") && Input.is_key_pressed(KEY_ALT):
			MyUtils.delete_children(self)

## check the four cardinal stating to a Vertex direction lenght thicknnesBorder collider with polygon's Arena and return
## a offset for the projection of the Vertex 
## taking the current Vertex id of polygon's Arena
## return Vector2(-1,-1) for error
func line_overlap_polygon(currentVertexId: int) -> Vector2:
	if (currentVertexId < 0):
		return Vector2(-1, -1)
	var currentVertex = self.polygon[currentVertexId]
	var nextVertex = self.polygon[currentVertexId + 1 if currentVertexId < self.polygon.size() - 1 else 0]
	return Vector2()

# add all collisionShape (Polygon2d) at the border's Arena
func algo(): 
	# on parse un à un tout les sommet du polygon de l'Arena
	for vertexId in range(0, self.polygon.size()):
	# d'abord on chope les deux sommets pour avoir le vecteur coté
		var currentVertex = self.polygon[vertexId]
		var dirCurrent = currentVertex.normalized()
		var nextVertex = self.polygon[vertexId + 1 if vertexId < self.polygon.size() - 1 else 0]
		var dirNext = nextVertex.normalized() 
		var vectorEgde = Vector2(nextVertex.x - currentVertex.x, nextVertex.y - currentVertex.y)
		var dirEdge = vectorEgde.normalized()
	## ensuite chopé la normale du vecteur coté dans les deux sens (pour check où est l'exterieur du polygon) 
		var normal1 = Vector2(dirEdge.y, - dirEdge.x)
		var normal2 = Vector2(-dirEdge.y, dirEdge.x)
		# to handle the case polgon is concave, the project need to be from the middle of the edge
		var middleEdge = (currentVertex + nextVertex) / 2 
	# là on chercher la normale qui va vers l'exterrieur du polygon
		var normal1Collision = Geometry2D.intersect_polyline_with_polygon([middleEdge, middleEdge + normal1], self.polygon)
		var extNormal = normal2 if normal1Collision.size() > 0 else normal1	
#	## là utilsé les deux sommets avec la noramle extérieur
		var projCurrent = currentVertex + extNormal * thicknessBorder
		var projNext = nextVertex + extNormal * thicknessBorder
	## là on check les collisions entre les sommets et leurs projection et aussi la ligne formé par les projections
		if get_angle_at_point(vertexId) < 180:
			print("hello", vertexId, "  |   ", get_angle_at_point(vertexId))
		var projCurrentCollision = Geometry2D.intersect_polyline_with_polygon([currentVertex, projCurrent], self.polygon)
		var projCollidedCurrent = projCurrent if projCurrentCollision.size() == 0 else projCurrentCollision[0][0]
		MyUtils.addDebugLine(self, [currentVertex, projCollidedCurrent], Color(255, 0, 0, 1))
		var projNextCollision = Geometry2D.intersect_polyline_with_polygon([nextVertex, projNext], self.polygon)
		var projCollidedNext = projNext if projNextCollision.size() == 0 else projNextCollision[0][0]
		MyUtils.addDebugLine(self, [nextVertex, projCollidedNext], Color(0, 0, 255, 1))
	## si la fonction ne renvoie pas de points de collision juste ajouter un collider à quatre coté (currentVertex, projectCurrentVertex, projectionNextVertex, nextVertex)
	## sinon faire un collider en partant de currentVertex et relie nextVertex en passant par tout les points de collision
	##
	##
	## garder un buffer des deux points du coté former par les coordonées de NextVertex et sa projection (pour lier au poylgon de collision suivant en mode triangle)
	##
	#
	pass

# A proper Arena must have at least 3 point
func get_angle_at_point(index: int) -> float:
	var prevVertex = self.polygon[index - 1] if index > 0 else self.polygon[self.polygon.size() - 1]
	var currentVertex = self.polygon[index]
	var nextVertex = self.polygon[index + 1] if index < self.polygon.size() - 1 else self.polygon[0]
	return rad_to_deg(Vector2(currentVertex.x - prevVertex.x, currentVertex.y - prevVertex.y).angle_to_point(nextVertex))
