extends Control

@export var Player_1_Goal_Health = 100
@export var Player_2_Goal_Health = 100

@export var Player_1_Stun_Percentage = 0
@export var Player_2_Stun_Percentage = 0

func _ready() -> void:
	$"MarginContainer/VBoxContainer/Player 1 Health/Player 1 Health".text = str(Player_1_Goal_Health)
	$"MarginContainer2/VBoxContainer2/HBoxContainer2/Player 2 Health".text = str(Player_2_Goal_Health)
	
	$"MarginContainer/VBoxContainer/HBoxContainer3/Player 1 Stun".text = str(Player_1_Stun_Percentage)
	$"MarginContainer2/VBoxContainer2/HBoxContainer/Player 2 Stun".text = str(Player_2_Stun_Percentage)

func _on_player_1_goal_damage_taken(health: float) -> void:
	Player_1_Goal_Health = health
	$"MarginContainer/VBoxContainer/Player 1 Health/Player 1 Health".text = str(Player_1_Goal_Health)


func _on_player_2_goal_damage_taken(health: float) -> void:
	Player_2_Goal_Health = health
	$"MarginContainer2/VBoxContainer2/HBoxContainer2/Player 2 Health".text = str(Player_2_Goal_Health)


func _on_player_on_player_stun(stun_percentage: float) -> void:
	Player_1_Stun_Percentage = stun_percentage
	$"MarginContainer/VBoxContainer/HBoxContainer3/Player 1 Stun".text = str(Player_1_Stun_Percentage)


func _on_player_2_on_player_stun(stun_percentage: float) -> void:
	Player_2_Stun_Percentage = stun_percentage
	$"MarginContainer2/VBoxContainer2/HBoxContainer/Player 2 Stun".text = str(Player_2_Stun_Percentage)
