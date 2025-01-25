extends Control

@export var Player_1_Goal_Health = 100
@export var Player_2_Goal_Health = 100

@export var Player_1_Stun_Percentage = 0
@export var Player_2_Stun_Percentage = 0

func _ready() -> void:
	$"MarginContainer/HBoxContainer/Player 1 Health".text = str(Player_1_Goal_Health)
	$"MarginContainer2/HBoxContainer2/Player 2 Health".text = str(Player_2_Goal_Health)


func _on_player_1_goal_damage_taken(health: float) -> void:
	Player_1_Goal_Health = health
	$"MarginContainer/HBoxContainer/Player 1 Health".text = str(Player_1_Goal_Health)


func _on_player_2_goal_damage_taken(health: float) -> void:
	Player_2_Goal_Health = health
	$"MarginContainer2/HBoxContainer2/Player 2 Health".text = str(Player_2_Goal_Health)
