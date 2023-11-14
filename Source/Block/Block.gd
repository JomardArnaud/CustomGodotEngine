class_name Block2D
extends Polygon2D

func _ready():
	set_poly(polygon)
		
func set_poly(poly: PackedVector2Array)-> void:
	var body = StaticBody2D.new()
	var collision_shape = CollisionPolygon2D.new()
	collision_shape.polygon = poly
	body.add_child(collision_shape)
	add_child(body)
