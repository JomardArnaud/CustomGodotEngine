extends Node2D

enum NameSceneList {
	Playground
}

@export var sceneAtLaunch : NameSceneList

@onready var listScene := ["Playground"]
@onready var currentScene : Scene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	currentScene = load("res://Scenes/SC_" + listScene[sceneAtLaunch] + ".tscn").instantiate()
	add_child(currentScene)
	move_child(currentScene, 2)
