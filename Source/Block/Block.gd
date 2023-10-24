class_name Block2D
extends Polygon2D

func _ready():
#	z_index = SpriteManager.ZIndexArena
	set_poly(self.polygon)
		
func set_poly(poly: PackedVector2Array)-> void:
	var body = StaticBody2D.new()
	var collision_shape = CollisionPolygon2D.new()
	collision_shape.polygon = poly
	body.add_child(collision_shape)
	self.add_child(body)
