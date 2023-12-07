class_name RangedWeapon
extends Weapon

signal rangedAttack()
signal endRangedAttacking()
signal startReloading()
signal endReloading()
signal emptyMagazine()

@export var info : RangedWeaponInfo

@onready var attactArray := ["basicShot"]

func _ready() -> void:
	super()
	timerAttack.wait_time = info.fireRate
	distanceHolder = info.distanceHolder
	holder.add_user_signal("rangedAttack")
	holder.connect("rangedAttack", attack)
	attackFunc = Callable(self, attactArray[info.attackMode])

# const RAY_LENGTH = 10000
# func _physics_process(delta: float) -> void:
# 	var space_state = get_world_2d().direct_space_state
# 	var query = PhysicsRayQueryParameters2D.create(holder.get_global_position(), global_position + dirWeapon * RAY_LENGTH)
# 	query.exclude = [self]
# 	var result = space_state.intersect_ray(query)
# 	CustomUtils.clearDebugChildren(get_tree().get_root().get_child(0))
# 	if result:
# 		CustomUtils.addDebugLine(get_tree().get_root().get_child(0), Vector4(global_position.x, global_position.y, 
# 		result.position.x, result.position.y), Color(200, 75, 50), 1)

# just shot one projectil at the time
func basicShot() -> void:
	var tmpBullet = info.projScene.instantiate()
	add_child(tmpBullet)
	tmpBullet.setPosOrigin(get_global_position()).setDir(dirWeapon).setSpeed(info.speed).setDmg(info.dmg)
