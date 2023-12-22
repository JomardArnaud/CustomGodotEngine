class_name Main
extends Node2D

enum NameSceneList {
	MainMenu,
	Playground
}
const listScene = ["MainMenu", "Playground"]

@export var sceneAtLaunch : NameSceneList

@onready var currentScene : Scene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	currentScene = load("res://Scenes/SC_" + String(listScene[sceneAtLaunch]) + ".tscn").instantiate()
	add_child(currentScene)
	currentScene.switchingScene.connect(onSwitchinScene)
	
func onSwitchinScene(infoNextScene: Dictionary) -> void:
	currentScene = load("res://Scenes/SC_" + listScene[currentScene.switchToScene()] + ".tscn").instantiate()
	currentScene.setInfoFromPrevScene(infoNextScene)
	add_child(currentScene)
