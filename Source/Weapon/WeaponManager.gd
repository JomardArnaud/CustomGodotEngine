extends Node2D

const pathRangedWeapon = "res://Source/Weapon/Ranged/"
const pathMeleeWeapon = "res://Source/Weapon/Melee/"

enum NameWeaponEnum {
	RW_Smg,
	RW_Pistol
}
const listWeapon = ["RW_Smg", "RW_Pistol"]

@export var weaponCarriedName : Array[NameWeaponEnum]

@onready var holder : Node2D
#At ready will be the index 0 of weaponCarried
@onready var currentWeapon : Weapon
@onready var weaponCarried : Array[Weapon]

func _ready() -> void:
	holder = get_parent()
	if weaponCarriedName.size() == 0:
		return
	for idWeapon in range(0, weaponCarriedName.size()):
		weaponCarried.push_back(load(getWeaponPath(listWeapon[weaponCarriedName[idWeapon]])).instantiate())
	currentWeapon = weaponCarried[0]
	holder.add_child.call_deferred(currentWeapon)

func getWeaponPath(nameWeapon: String) -> String:
	var dest := pathRangedWeapon if nameWeapon.contains("RW_") else pathMeleeWeapon
	dest = dest + nameWeapon + ".tscn"
	return dest

func switchWeapon() -> void:
	pass 
