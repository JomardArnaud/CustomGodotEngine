class_name RangedWeapon
extends Weapon

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
	holder.connect("rangedAttack", setOnAttack)
	attackFunc = Callable(self, attactArray[info.attackMode])

# just shot one projectil at the time
func basicShot() -> void:
	var tmpBullet = info.projScene.instantiate()
	add_child(tmpBullet)
	tmpBullet.setPosOrigin(get_global_position()).setDir(dirWeapon).setSpeed(info.speed).setDmg(info.dmg)
