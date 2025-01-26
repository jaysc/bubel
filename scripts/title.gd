extends Node2D

var nextScene = preload("res://scenes/main.tscn")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene_to_packed(nextScene)
