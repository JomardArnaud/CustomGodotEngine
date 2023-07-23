class_name MyUtils
extends Node

const debugPath = "Debug"

static func delete_children(node):
	for n in node.get_children():
		node.remove_child(n)
		n.queue_free()


### VISUAL DEBUG PART ###
static func findDebugNode(node: Node2D) -> Node2D :
	return (node.find_child(debugPath, false, false))
	
static func clearDebugChildren(node: Node2D) -> void:
	var debugNode = findDebugNode(node)
	if debugNode != null:
		delete_children(debugNode)

static func addDebugLine(node: Node2D, points: Array[Vector2], color: Color = Color(255,255, 255, 1), thickness: int = 5) -> void:
	var debugLine = Line2D.new()
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
	
		
