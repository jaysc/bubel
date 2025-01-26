extends Node2D

var looped_amount = 0
const MAX_LOOP_AMOUNT = 3

func on_hit() -> void:
	$AnimatedSprite2D.speed_scale = 1
	$AnimatedSprite2D.play()

func _on_animated_sprite_2d_animation_looped() -> void:
	if looped_amount >= MAX_LOOP_AMOUNT:
		$AnimatedSprite2D.pause()
		$AnimatedSprite2D.speed_scale = 0
		$AnimatedSprite2D.frame = 0
		looped_amount = 0

	looped_amount += 1
