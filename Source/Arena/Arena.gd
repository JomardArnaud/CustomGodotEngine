@tool
extends Polygon2D

### TODO =>
#______________________#
## faire une "class vertexVector avec la pos et la dir

@export var posArena : Vector2
@export var colorArena : Color
@export var colorWall : Color
## make a BETTER slider and listen the signal to auto update the border's Arena
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
			algo()
		if Input.is_action_just_pressed("refreshEditor") && Input.is_key_pressed(KEY_ALT):
			MyUtils.delete_children(self)

## add the collisionShape as child to the scene Border of the Arena
func place_border():
	MyUtils.delete_children(self)
	print("place border")
	for VertexId in range(0, self.polygon.size()):
		var bufferLastVertexProjection: Vector2
		## if next_Vertex_concave == true
		## add the point to 
		
		var currentVertex = self.polygon[VertexId]
		var nextVertex = self.polygon[VertexId + 1 if VertexId < self.polygon.size() - 1 else 0]
		var normalVertexToNextVertex = Vector2(nextVertex.x - currentVertex.x, nextVertex.y - currentVertex.y)
		var debugLine = Line2D.new()
		debugLine.add_point(self.polygon[VertexId])
		debugLine.add_point(normalVertexToNextVertex)
		debugLine.default_color = Color(255, 0, 0, 0.75)
		self.add_child(debugLine)
		var debugVertexLine = Line2D.new()
		debugVertexLine.add_point(currentVertex)
		debugVertexLine.add_point(nextVertex)
		debugVertexLine.default_color = Color(0, 0, 255, 0.75)
		self.add_child(debugVertexLine)
	pass

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
		var normal1 = Vector2(dirEdge.y, - dirEdge.x) * thicknessBorder
		var normal2 = Vector2(-dirEdge.y, dirEdge.x) * thicknessBorder
		
		var normalVertexToNextVertex = Vector2(nextVertex.x - currentVertex.x, nextVertex.y - currentVertex.y)
		var debugLine = Line2D.new()
		debugLine.add_point(currentVertex)
		debugLine.add_point(normal1 + currentVertex)
		debugLine.default_color = Color(255, 127, 0, 0.75)
		self.add_child(debugLine)
		var debugLine2 = Line2D.new()
		debugLine2.add_point(currentVertex)
		debugLine2.add_point(normal2 + currentVertex)
		debugLine2.default_color = Color(255, 0, 127, 0.75)
		self.add_child(debugLine2)
		var debugLineNext = Line2D.new()
		debugLineNext.add_point(nextVertex)
		debugLineNext.add_point(normal1 + nextVertex)
		debugLineNext.default_color = Color(255, 127, 0, 0.75)
		self.add_child(debugLineNext)
		var debugLine2Next = Line2D.new()
		debugLine2Next.add_point(nextVertex)
		debugLine2Next.add_point(normal2 + nextVertex)
		debugLine2Next.default_color = Color(255, 0, 127, 0.75)
		self.add_child(debugLine2Next)
		var debugLine1Poly = Line2D.new()
		debugLine1Poly.add_point(normal1 + currentVertex)
		debugLine1Poly.add_point(normal1 + nextVertex)
		debugLine2Next.default_color = Color(255, 0, 255, 0.75)
		var debugLine2Poly = Line2D.new()
		debugLine2Next.add_point(normal2 + currentVertex)
		debugLine2Next.add_point(normal2 + nextVertex)
		debugLine2Next.default_color = Color(255, 0, 255, 0.75)
		self.add_child(debugLine2Next)
		var debugVertexLine = Line2D.new()
		debugVertexLine.add_point(currentVertex)
		debugVertexLine.add_point(nextVertex)
		debugVertexLine.default_color = Color(0, 0, 255, 0.75)
		self.add_child(debugVertexLine)
	## là utilsé la normale pour projecter une ligne depuis les deux sommets
	## avec cette lignes faire un test de collision entre cette line et le polygon de l'Arena
	## si la fonction ne renvoie pas de points de collision juste ajouter un collider à quatre coté (currentVertex, projectCurrentVertex, projectionNextVertex, nextVertex)
	## sinon faire un collider en partant de currentVertex et relie nextVertex en passant par tout les points de collision
	##
	##
	## garder un buffer des deux points du coté former par les coordonées de NextVertex et sa projection (pour lier au poylgon de collision suivant )
	##
	#
	pass
