class_name MeleeWeapon
extends Weapon

@onready var attackScene := load("res://Source/Weapon/Melee/MeleeAttack/BasicAttack.tscn")

func init(nHolder: Node2D) -> void:
    super(nHolder)

func update() -> void:
    super()

static func create(nHolder: Node2D, nWeaponScene: Resource) -> MeleeWeapon:
    var nMeleeWeapon = nWeaponScene.instantiate()
    nMeleeWeapon.init(nHolder)
    nHolder.add_child(nMeleeWeapon)
    return nMeleeWeapon

static func stab(weapon: MeleeWeapon) -> void:
    var tmpAttack = weapon.getCurrentAttack().instantiate()
    weapon.getHolder().add_child(tmpAttack)
    
    pass

# Temporary, need to add a currentAttack system
func getCurrentAttack() -> Resource:
    return attackScene