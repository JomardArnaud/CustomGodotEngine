class_name RangedWeaponInfo
extends Resource

enum AttackMode {
	basicShot
}

# projectil's scene
@export var projScene : PackedScene
# func which will be call to instance the projScene
@export var attackMode : AttackMode
# damage dealt by the projectil
@export var dmg : float
# speed's projectil
@export var speed : float
# timer between shot weapon
@export var fireRate : float
# current number's projectil in the magazine
@export var currentNbProj : int
# size magazine
@export var magazineSize : int
# time to reload : holder unable to move without cancel
@export var reloadTime : float
# distance to place the weapon from holder
@export var distanceHolder : float