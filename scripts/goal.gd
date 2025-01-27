extends Area2D

@export var health := 100;
@export var group: Constants.TeamEnum

signal Damage_taken(new_health: float)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group(str(group))
	var guards = get_tree().get_nodes_in_group(str(group))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area: Area2D) -> void:
	var bubbleSize = area.get_parent().get("SIZE")
	if bubbleSize != null: 
		health -= ceil(bubbleSize/10) * 3
	
	Damage_taken.emit(health)
	pass # Replace with function body.


func _on_player_on_player_stun(stun_percentage: float) -> void:
	pass # Replace with function body.
