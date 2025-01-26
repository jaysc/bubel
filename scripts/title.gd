extends Node2D

var nextScene = preload("res://scenes/main.tscn").instantiate()


func _on_button_button_down() -> void:
	get_tree().root.add_child(nextScene)
