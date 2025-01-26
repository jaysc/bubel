extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area: Area2D) -> void:
	var target_bubble_size = area.get_parent().get("SIZE")
	if target_bubble_size:
		print(target_bubble_size)
		if target_bubble_size > get_parent().get("SIZE"):
			print('bubble hit size')
			get_parent().queue_free()
		else:
			print('bubble hit shrink')
			get_parent().createBubbleObject(get_parent().get("SIZE") - target_bubble_size)
			pass
			#handle shrink
