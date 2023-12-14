class_name Main
extends Node2D

enum NameSceneList {
	MainMenu,
	Playground
}

@export var sceneAtLaunch : NameSceneList

@onready var listScene := ["MainMenu", "Playground"]
@onready var currentScene : Scene
@onready var pause := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	currentScene = load("res://Scenes/SC_" + listScene[sceneAtLaunch] + ".tscn").instantiate()
	add_child(currentScene)
	currentScene.switchingScene.connect(onSwitchinScene)

func _input(event: InputEvent) -> void:
	if (event.is_action_pressed("pause")):
		pause = !pause
		get_tree().paused = pause
	
func onSwitchinScene(infoNextScene: Dictionary) -> void:
	currentScene = load("res://Scenes/SC_" + listScene[currentScene.switchToScene()] + ".tscn").instantiate()
	currentScene.setInfoFromPrevScene(infoNextScene)
	add_child(currentScene)
