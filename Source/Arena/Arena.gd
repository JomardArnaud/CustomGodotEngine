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
		
		var currentEdge = self.polygon[edgeId]
		var nextEdge = self.polygon[edgeId + 1 if edgeId < self.polygon.size() - 1 else 0]
		var normalEdgeToNextEdge = Vector2(nextEdge.x - currentEdge.x, nextEdge.y - currentEdge.y)
		var debugLine = Line2D.new()
		debugLine.add_point(self.polygon[edgeId])
		debugLine.add_point(normalEdgeToNextEdge)
		debugLine.default_color = Color(255, 0, 0, 0.75)
		self.add_child(debugLine)
		var debugEdgeLine = Line2D.new()
		debugEdgeLine.add_point(currentEdge)
		debugEdgeLine.add_point(nextEdge)
		debugEdgeLine.default_color = Color(0, 0, 255, 0.75)
		self.add_child(debugEdgeLine)
	pass

## check the four cardinal stating to a edge direction lenght thicknnesBorder collider with polygon's Arena and return
## a offset for the projection of the edge 
## taking the current edge id of polygon's Arena
## return Vector2(-1,-1) for error
func line_overlap_polygon(currentEdgeId: int) -> Vector2:
	if (currentEdgeId < 0):
		return Vector2(-1, -1)
	var currentEdge = self.polygon[currentEdgeId]
	var nextEdge = self.polygon[currentEdgeId + 1 if currentEdgeId < self.polygon.size() - 1 else 0]
	return Vector2()

# add all collisionShape (Polygon2d) at the border's Arena
func algo(): 
	# on parse un à un tout les sommet du polygon de l'Arena
	##for edgeId in range(0, self.polygon.size()):
	# d'abord on chope les deux sommets pour avoir le vecteur coté
	#	var currentEdge = self.polygon[edgeId]
	#	var nextEdge = self.polygon[edgeId + 1 if edgeId < self.polygon.size() - 1 else 0]
	## ensuite chopé la normale du vecteur coté dans les deux sens (pour check où est l'exterieur du polygon) 
	##
	## là utilsé la normale pour projecter une ligne depuis les deux sommets
	## avec cette lignes faire un test de collision entre cette line et le polygon de l'Arena
	## si la fonction ne renvoie pas de points de collision juste ajouter un collider à quatre coté (currentEdge, projectCurrentEdge, projectionNextEdge, nextEdge)
	## sinon faire un collider en partant de currentEdge et relie nextEdge en passant par tout les points de collision
	##
	##
	## garder un buffer des deux points du coté former par les coordonées de NextEdge et sa projection (pour lier au poylgon de collision suivant )
	##
	#
	pass
