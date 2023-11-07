class_name RangedWeapon
extends Weapon

const RAY_LENGTH = 10000

@onready var tmpNode : Node2D : set = setTmpNode, get = getTmpNode
@onready var bulletScene := load("res://Source/Weapon/Ranged/Bullet/Bullet.tscn")
@onready var speed : float

func init(nHolder: Node2D)-> void:
	super(nHolder)

func update() -> void:
	super()

func _physics_process(delta: float) -> void:
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(holder.get_global_position(), global_position + dirWeapon * RAY_LENGTH)
	query.exclude = [self]
	var result = space_state.intersect_ray(query)
	CustomUtils.clearDebugChildren(get_tree().get_root().get_child(0))
	if result:
		CustomUtils.addDebugLine(get_tree().get_root().get_child(0), Vector4(global_position.x, global_position.y, 
		result.position.x, result.position.y), Color(200, 75, 50), 1)

static func create(nHolder: Node2D, nWeaponScene: Resource) -> RangedWeapon:
	var nRangedWeapon = nWeaponScene.instantiate()
	nRangedWeapon.init(nHolder)
	nHolder.add_child(nRangedWeapon)
	return nRangedWeapon

static func shot(weapon: RangedWeapon, tmpNode: Node2D) -> void:
	var tmpBullet = weapon.getCurrentBullet().instantiate()
	weapon.getTmpNode().add_child(tmpBullet)
	tmpBullet.posOrigin(weapon.get_global_position()).setDir(weapon.getDir()).setSpeed(4)

func getSpeed() -> float:
	return speed
	
func setSpeed(nSpeed: float) -> RangedWeapon:
	speed = nSpeed
	return self

func getTmpNode() -> Node2D:
	return tmpNode

func setTmpNode(nTmp: Node2D) -> RangedWeapon:
	tmpNode = nTmp	
	return self


# Temporary, need to add a bullet gestion system
func getCurrentBullet() -> Resource:
	return bulletScene
