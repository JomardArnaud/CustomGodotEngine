class_name MeleeWeapon
extends Weapon

@onready var attackScene := load("res://Source/Weapon/Melee/MeleeAttack/BaseAttack.tscn")

func init(nHolder: Node2D) -> void:
	super(nHolder)

func update() -> void:
	super()
	look_at(get_global_mouse_position())

static func create(nHolder: Node2D, nWeaponScene: Resource) -> MeleeWeapon:
	var meleeWeapon = nWeaponScene.instantiate()
	meleeWeapon.init(nHolder)
	nHolder.add_child(meleeWeapon)
	return meleeWeapon

static func hit(weapon: MeleeWeapon) -> void:
	var tmpAttack = weapon.getCurrentAttack().instantiate()
	weapon.getHolder().add_child(tmpAttack)
	tmpAttack.setPosOrigin(weapon.getPos()).set_rotation(weapon.get_rotation())

# Temporary, need to add a currentAttack system
func getCurrentAttack() -> Resource:
	return attackScene
