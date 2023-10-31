class_name RangedWeapon
extends Weapon

@onready var bulletScene := load("res://Source/Weapon/Ranged/Bullet/Bullet.tscn")
@onready var speed : float

func init(nHolder: Node2D, nAttack: Callable = Callable())-> void: #, nAttack: Callable
	var tmpNode := get_tree().get_root().get_node("TmpNode")
	super(nHolder, shot.bind(self, tmpNode)) #must change tmpNode at one point ####
	

func update() -> void:
	super()

func _physics_process(delta: float) -> void:
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(holder.get_global_position(), global_position)
	query.exclude = [self]
	var result = space_state.intersect_ray(query)
	pass

static func shot(weapon: RangedWeapon, tmpNode: Node2D) -> void:
	var tmpBullet = weapon.getCurrentBullet().instantiate()
	tmpNode.add_child(tmpBullet)
#	MainScene.tmpNode.add_child(tmpBullet)
	tmpBullet.posOrigin(weapon.global_position).setDir(weapon.getDir()).setSpeed(4)

func getSpeed() -> float:
	return speed
	
func setSpeed(nSpeed: float) -> RangedWeapon:
	speed = nSpeed
	return self

func getCurrentBullet() -> Resource:
	return bulletScene
