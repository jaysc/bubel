extends Node2D

var nextScene = preload("res://scenes/main.tscn")


func _on_button_button_down() -> void:
	get_tree().change_scene_to_packed(nextScene)
