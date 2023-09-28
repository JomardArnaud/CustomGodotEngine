@tool
extends Polygon2D

### TODO =>
#______________________#

@export var posArena : Vector2
@export var colorArena : Color
@export var colorWall : Color
## make a BETTER slider and listen the signal to auto update the border's Arena
@export_range(0.1, 5, 0.1) var thicknessBorder = 0.5

# Ok alors faire un algo qui permet de prendre le polygon, et faire un prolongement en partant du centrre du polygon
# vers chaque vertice pour scale le polygon d'origin et produire celui qui sera le border

static var DictStateEdge = {
	current = Vector2(),
	next = Vector2(),
	edgeProjected = Vector4(),
	edgeProlonged = Vector4(),
	dirEdge = Vector2(),
	sweetSpot = Vector2()
}

func _ready():
	if !Engine.is_editor_hint():
		pass
	# to avoid crash when the Arena is masked on scene
	if self.visible != false:
		algo(self.polygon.size())
	
func _process(delta):
	if Engine.is_editor_hint():
		if Input.is_action_pressed("refreshEditor") && Input.is_key_pressed(KEY_CTRL):
			MyUtils.delete_children(self)
			# to avoid crash when the Arena is masked on scene
			if self.visible != false:
				algo(self.polygon.size())
		if Input.is_action_just_pressed("refreshEditor") && Input.is_key_pressed(KEY_ALT):
			MyUtils.delete_children(self)

# add all collisionShape (Polygon2d) at the border's Arena
func algo(nbVertexPoly):
	var firstSweetSpot: Vector2
	
	var pointsExtBorder: PackedVector2Array
	var bufferDict = DictStateEdge.duplicate()
	var stateVertex = DictStateEdge.duplicate()
	
	bufferDict["current"] = self.polygon[nbVertexPoly - 1]
	bufferDict["next"] = self.polygon[0]
	
	## on passe en param la normal ext
	##on projette et pronlonge, par les deux bouts, le segment formé par les deux sommets
	prolongEdge(bufferDict, getNormalExt(bufferDict))
	# on parse un à un tout les sommet du polygon de l'Arena
	for vertexId in range(0, nbVertexPoly):
		# d'abord on chope les deux sommets pour avoir le vecteur coté
		stateVertex["current"] = self.polygon[vertexId]
		stateVertex["next"] = self.polygon[(vertexId + 1) * int(vertexId + 1 < nbVertexPoly)]
		
		## on passe en param la normal ext
		## on projette et pronlonge, par les deux bouts, le segment formé par les deux sommets
		prolongEdge(stateVertex, getNormalExt(stateVertex))
		## on trouve le sweetspot avec la collision des deux prolongement	
		setSweetSpot(stateVertex, bufferDict)
		if (vertexId == 0):
			firstSweetSpot = stateVertex["sweetSpot"]
		#on ajoute les points pour la bordure extérieure
		pointsExtBorder.append(stateVertex["sweetSpot"])
#		# on set les buffer
		bufferDict["current"] = stateVertex["current"]
		bufferDict["next"] = stateVertex["next"]
		bufferDict["edgeProjected"] = stateVertex["edgeProjected"]
		bufferDict["edgeProlonged"] = stateVertex["edgeProlonged"]
	# just adding all the polygon's vertex to finish the first block
	for vertexId in range(nbVertexPoly - 1, -1, -1):
		pointsExtBorder.append(self.polygon[vertexId])
	var blockBorder = Block2D.new()
	blockBorder.polygon = pointsExtBorder
	blockBorder.set_poly(blockBorder)
	self.add_child(blockBorder)
	var blockDoor = Block2D.new()
	blockDoor.polygon = [firstSweetSpot, stateVertex["next"], stateVertex["current"], stateVertex["sweetSpot"]]
	blockDoor.set_poly(blockDoor)
	self.add_child(blockDoor)

func getNormalExt(state: Dictionary) -> Vector2:
	state["dirEdge"] = Vector2(state["next"].x - state["current"].x,state["next"].y - state["current"].y).normalized()
		
	# ensuite chopé la normale du vecteur coté dans les deux sens (pour check où est l'exterieur du polygon) 
	var normal1 = Vector2(state["dirEdge"].y, -state["dirEdge"].x)
	var normal2 = Vector2(-state["dirEdge"].y, state["dirEdge"].x)

	# là on chercher la normale qui va vers l'exterrieur du polygon
		#on prend le milieu pour éviter que les deux normales collider avec le polygone
	var middleEdge = (state["current"] + state["next"]) / 2
	var normal1Collision = Geometry2D.intersect_polyline_with_polygon([middleEdge, middleEdge + normal1], self.polygon)
	return(normal2 if normal1Collision.size() > 0 else normal1)

func prolongEdge(state: Dictionary, normalExt: Vector2) -> void:
	state["edgeProjected"] = Vector4(state["current"].x + normalExt.x * thicknessBorder, state["current"].y + normalExt.y * thicknessBorder,
		state["next"].x + normalExt.x * thicknessBorder, state["next"].y + normalExt.y * thicknessBorder)
	# on prolonge le coté par les deux bouts direct pour que l'autre bout servent pour le buffer
	state["edgeProlonged"] = Vector4(state["edgeProjected"].x - state["dirEdge"].x * 100, state["edgeProjected"].y - state["dirEdge"].y * 100,
		state["edgeProjected"].z + state["dirEdge"].x * 100, state["edgeProjected"].w + state["dirEdge"].y * 100)

func setSweetSpot(currentState: Dictionary, bufferState: Dictionary) -> void:
	currentState["sweetSpot"] = Geometry2D.segment_intersects_segment(Vector2(currentState["edgeProlonged"].x, currentState["edgeProlonged"].y),
		Vector2(currentState["edgeProlonged"].z, currentState["edgeProlonged"].w),
		Vector2(bufferState["edgeProlonged"].x, bufferState["edgeProlonged"].y),
		Vector2(bufferState["edgeProlonged"].z, bufferState["edgeProlonged"].w))
