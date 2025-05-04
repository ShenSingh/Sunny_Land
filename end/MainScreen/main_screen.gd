extends Node2D


@onready var scene_tree = get_tree()



@export var levelSelectScene: PackedScene

func _get_configuration_warnings():
	return "ERR! Next level scene is empty" if not levelSelectScene else ""


func _on_play_button_down() -> void:
	scene_tree.change_scene_to_packed(levelSelectScene)


func _on_exit_button_down() -> void:
	scene_tree.quit()
