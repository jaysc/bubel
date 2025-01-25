extends StaticBody2D

@export var health := 100;
@export var group: Constants.TeamEnum
signal goal_finish

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group(str(group))
	var guards = get_tree().get_nodes_in_group(str(group))
	pass # Replace with function body.

func take_damage(damage: float) -> void:
	health -= damage
	
	if health < 0:
		goal_finish.emit();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
