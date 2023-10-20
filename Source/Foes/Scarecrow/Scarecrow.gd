extends Node2D

@export var maxHP: int = 100

@onready var hp : HealthManager

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	z_index = 50
	hp = HealthManager.new()
	hp.setMaxHealth(maxHP).setHealth(maxHP)
	hp.connect("healthChanged", onHealthChanged)
	print("scarecrow max hp is ", hp.getMaxHealth())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func onHealthChanged(nHP: int) -> void:
	print(nHP)

func getHP() -> HealthManager:
	return self.hpdz

func _on_area_2d_body_entered(body: Node2D) -> void:
	print("tiens teins teins")
