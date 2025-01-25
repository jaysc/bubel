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
	print('ENTERED')
	health -= 10
	
	Damage_taken.emit(health)
	pass # Replace with function body.
