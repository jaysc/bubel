extends Area2D

func _process(delta: float) -> void:
	var defense_button = Input.is_action_pressed("Defense_" + str(get_parent().playerID))
	if defense_button:
		var areas = get_overlapping_areas()
		if areas:
			for area in areas:
				var bubble_size = area.get_parent().get("SIZE")
				if bubble_size:
					var bubble = area.get_parent();
					var shoot_direction = get_parent().clampedDirection.normalized()
					
					bubble.handle_rebound(shoot_direction)
					
