class_name RangedWeapon
extends Weapon

@onready var tmpNode := get_node("/root/Main/TmpNode")
@onready var bulletScene := load("res://Source/Weapon/Ranged/Bullet/Bullet.tscn")

func init(attack: Callable)-> void:
	super(attack)

func update(entity: Node2D) -> void:
	super(entity)
	
func shot() -> void:
	var tmpBullet = bulletScene.instantiate()
	tmpNode.add_child(tmpBullet)
	tmpBullet.posOrigin(self.global_position).setDir(dirWeapon).setSpeed(6)
