extends Area2D

func _process(delta: float) -> void:
	var areas = get_overlapping_areas()
	if areas:
		for area in areas:
			var bubble_size = area.get_parent().get("SIZE")
			if bubble_size:
				var bubble = area.get_parent();
				bubble.handle_rebound(Vector2.UP * 0.5)
					
