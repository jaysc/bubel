extends Node2D

@export var health: float = 100;
@export var is_destroyed := false;

var looped_amount = 0
const MAX_LOOP_AMOUNT = 3

func on_hit(damage: float) -> void:
	if is_destroyed:
		return
		
	health -= damage
	$AnimatedSprite2D.speed_scale = 1
	$AnimatedSprite2D.play()
	get_parent().on_barrel_hit(damage)
	
	if health <= 0:
		destory_barrel()

func _on_animated_sprite_2d_animation_looped() -> void:
	if looped_amount >= MAX_LOOP_AMOUNT:
		$AnimatedSprite2D.pause()
		$AnimatedSprite2D.speed_scale = 0
		$AnimatedSprite2D.frame = 0
		looped_amount = 0

	looped_amount += 1
	
func destory_barrel() -> void:
	is_destroyed = true
	get_parent().on_barrel_destroy()
	pass


func _on_area_entered(area: Area2D) -> void:
	var target_bubble_size = area.get_parent().get('SIZE')
	if target_bubble_size:
		on_hit(target_bubble_size / 10)
		area.get_parent().destroyBubble()
