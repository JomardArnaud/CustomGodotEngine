class_name Scene
extends Node

signal switchingScene(Dictionary)

@export var idNextScene : Main.NameSceneList

var infoPrevScene : Dictionary

func passInfoToNextScene() -> Dictionary:
    return {}

func setInfoFromPrevScene(nInfoPrevScene: Dictionary) -> void:
    infoPrevScene = nInfoPrevScene

func cleanScene() -> void:
    call_deferred("queue_free")

func switchToScene() -> Main.NameSceneList:
    cleanScene()
    return idNextScene