class_name RangedWeapon
extends Weapon

signal startReloading()
signal endReloading()
signal emptyMagazine()

const pathInfoWeapon = "res://Source/Weapon/Ranged/RangedWeaponInfo/"

@export var nameWeapon : String
# @export var pathSprite : String :
# 	set (nPath):
# 		pathSprite = nPath
# 		#try do refresh the sprite

@onready var attactArray := ["basicShot"]
@onready var info : RangedWeaponInfo
#tmp
@onready var listNameWeapon : Array
@onready var idWeapon : int
func _ready() -> void:
	super()
	setInfoWeapon()
	setListNameWeapon()
	holder.connect("rangedAttack", setOnAttack)

func _process(delta: float) -> void:
	if not Engine.is_editor_hint():
		super(delta)

# just shot one projectil at the time
func basicShot() -> void:
	var tmpBullet = info.projScene.instantiate()
	add_child(tmpBullet)
	tmpBullet.setPosOrigin(get_global_position()).setDir(dirWeapon).setSpeed(info.speedBullet).setDmg(info.dmg)

func setInfoWeapon() -> void:
	var pathResWeapon = pathInfoWeapon + nameWeapon + ".tres"
	if !FileAccess.file_exists(pathResWeapon) == true:
		printerr("Path for weapon's info not found: " + nameWeapon + " |-> Not_found.tres will be load instead")
		nameWeapon =  "NotFound"
		pathResWeapon = pathInfoWeapon + nameWeapon + ".tres"
	info = load(pathResWeapon)
	timerAttack.wait_time = info.fireRate
	distanceHolder = info.distanceHolder
	attackFunc = Callable(self, attactArray[info.attackMode])

func switchWeapon(nNameWeapon: String) -> void:
	nameWeapon = nNameWeapon
	setInfoWeapon()

func setListNameWeapon() -> void:
	var dirInfoWeapon = DirAccess.open(pathInfoWeapon)
	if (dirInfoWeapon == null):
		printerr(DirAccess.get_open_error())
		return
	listNameWeapon = dirInfoWeapon.get_files()
	idWeapon = listNameWeapon.find(nameWeapon + ".tres")
	print(listNameWeapon, idWeapon)