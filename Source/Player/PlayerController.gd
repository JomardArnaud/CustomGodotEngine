extends CharacterBody2D

@export var speed = 500
@export var inertia = .0035
 
@onready var movement : MovementManager

func _ready():
	print("player ready")
	self.movement = MovementManager.new()
	self.movement.speed = speed
	self.movement.inertia = inertia

func _physics_process(delta):
	get_dir()
	movement.update_velocity(delta)
	self.set_velocity(movement.get_velocity())
	self.move_and_slide()

func get_dir():
	var horizontalDirection = int(Input.is_action_pressed("moveLeft")) * -1 + int(Input.is_action_pressed("moveRight"))
	var verticalDirection = int(Input.is_action_pressed("moveUp")) * -1 + int(Input.is_action_pressed("moveDown"))
	self.movement.set_direction(Vector2(horizontalDirection, verticalDirection))

# là tu vas faire les armes 
## idée arme = une armes qui génère un bouclier court mais
## une attaque entre dans le shield  donne une charge de 
## super dash et du temps d'invicibilité
