class_name MyUtils
extends Node

const debugPath = "Debug"

# delete all children of given node
static func delete_children(node):
	for n in node.get_children():
		node.remove_child(n)
		n.queue_free()

### VISUAL DEBUG PART ###

# get the debug's node of a node 
static func findDebugNode(node: Node2D) -> Node2D :
	return (node.find_child(debugPath, false, false))

# get the debug's node and delete all of his debug children's node
static func clearDebugChildren(node: Node2D) -> void:
	var debugNode = findDebugNode(node)
	if debugNode != null:
		delete_children(debugNode)
	
# add a Line2d to the children of the node passed in param
static func addDebugLine(node: Node2D, line: Vector4, color: Color = Color(255,255, 255, 1), thickness: float = 0.5) -> void:
	var debugLine = Line2D.new()
	debugLine.z_index = 100
	debugLine.add_point(Vector2(line.x, line.y))
	debugLine.add_point(Vector2(line.z, line.w))
	debugLine.default_color = color
	debugLine.width = thickness
	var debugNode = findDebugNode(node)
	if debugNode == null:
		debugNode = Node2D.new()
		debugNode.name = debugPath
		node.add_child(debugNode)
	debugNode.add_child(debugLine)

# add a Line2d to the children of the node passed in param
static func addDebugLines(node: Node2D, points: Array[Vector2], color: Color = Color(255,255, 255, 1), thickness: float = 0.5) -> void:
	var debugLine = Line2D.new()
	debugLine.z_index = 100
	for point in points:
		debugLine.add_point(point)
	debugLine.default_color = color
	debugLine.width = thickness
	var debugNode = findDebugNode(node)
	if debugNode == null:
		debugNode = Node2D.new()
		debugNode.name = debugPath
		node.add_child(debugNode)
	debugNode.add_child(debugLine)
	
static func addDebugSquare(node: Node2D, pos: Vector2, size: Vector2 = Vector2(50,50), color: Color = Color(255, 255, 255, 1)) -> void:
	var debugSquare = ColorRect.new()
	debugSquare.z_index = 100
	debugSquare.color = color
	debugSquare.global_position = pos
	debugSquare.z_as_relative = true
	debugSquare.size = size
	var	debugNode = findDebugNode(node)
	if debugNode == null:
		debugNode = Node2D.new()
		debugNode.name = debugPath
		node.add_child(debugNode)
	debugNode.add_child(debugSquare)