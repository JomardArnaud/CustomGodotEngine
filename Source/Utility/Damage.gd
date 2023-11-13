class_name Damage
extends Object

#for DOT, have a tick duration and a total duration to stop the tick timer, at each tickTimerTimeout inflige the dmg (or maybe dmg/tick to have a better readly on dmg total of a ability)
var info := {
    dmg = 0,
    duration = 0
} : get = getInfo

static func createDmg(nDmg: float, nDuration: float = 0) -> Damage:
    var nDamage := Damage.new()
    nDamage.getInfo().dmg = nDmg
    if nDuration != 0:
        #create and add a timer, also connect the signal maybe add tick do dmg overtime for a v2
        pass
    return nDamage

func getInfo() -> Dictionary:
    return info