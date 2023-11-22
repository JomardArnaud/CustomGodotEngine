class_name Damage
extends Node2D

var dmg : float : set = setDmg, get = getDmg
# for getting the HealthManager and also info for calculing the final damage output, like armor for example
var target : Node2D : set = setTarget, get = getTarget

## For V2 and Gestion DOT
# for DOT, have a tick duration and a total duration to stop the tick timer, at each tickTimerTimeout inflige the dmg (or maybe dmg/tick to have a better readly on dmg total of a ability)
# var timerTick : Timer
# var timerDuration : Timer

static func addDmg(nTarget: Node2D, nDmg: float, _nDurationTick: float = 0, _nDuration: float = 0) -> void:
    var nDamage := Damage.new()
    
    nDamage.setTarget(nTarget).setDmg(nDmg)
    if _nDuration != 0:
        pass
        # nTarget.add_child(nDamage)
        #     #create and add a timer, also connect the signal maybe add tick do dmg overtime for a v2
        #     pass
    else :
        nDamage.applyDamage()
        nDamage.destroy()
        
func applyDamage() -> void:
    #here check stat which influ the dmg output
	# it is checked before that target has a HealthManager
    target.hp.takeDamage(dmg)
    pass

func getDmg() -> float:
    return dmg

func getTarget() -> Node2D:
    return target

func setDmg(nDmg: float) -> Damage:
    dmg = nDmg
    return self

func setTarget(nTarget: Node2D) -> Damage:
    target = nTarget
    return self

func destroy() -> void:
    queue_free()
