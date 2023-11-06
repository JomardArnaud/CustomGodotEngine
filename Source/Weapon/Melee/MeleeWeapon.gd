class_name MeleeWeapon
extends Weapon

func init(nHolder: Node2D) -> void:
    super(nHolder)
    print("coucou")

func update() -> void:
    super()


static func create(nHolder: Node2D, nWeaponScene: Resource) -> MeleeWeapon:
    var nMeleeWeapon = nWeaponScene.instantiate()
    nMeleeWeapon.init(nHolder)
    nHolder.add_child(nMeleeWeapon)
    return nMeleeWeapon