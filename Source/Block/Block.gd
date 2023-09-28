class_name Block2D

extends Polygon2D

func _ready():
	pass
	
func set_poly(poly: Polygon2D)-> void: 
	var body = StaticBody2D.new()
	var collision_shape = CollisionPolygon2D.new()
	collision_shape.polygon = poly.polygon
	self.color = Color(0, 125, 75)
	body.add_child(collision_shape)
	self.add_child(body)
