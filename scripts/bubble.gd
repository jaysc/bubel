extends Node2D

const BUBBLE_1_ENTITY = preload("res://entities/bubbles/bubble_1.tscn")
const BUBBLE_2_ENTITY = preload("res://entities/bubbles/bubble_2.tscn")
const BUBBLE_3_ENTITY = preload("res://entities/bubbles/bubble_3.tscn")
const BUBBLE_4_ENTITY = preload("res://entities/bubbles/bubble_4.tscn")
const BUBBLE_5_ENTITY = preload("res://entities/bubbles/bubble_5.tscn")
const BUBBLE_6_ENTITY = preload("res://entities/bubbles/bubble_6.tscn")
const BUBBLE_7_ENTITY = preload("res://entities/bubbles/bubble_7.tscn")
const BUBBLE_8_ENTITY = preload("res://entities/bubbles/bubble_8.tscn")
const BUBBLE_9_ENTITY = preload("res://entities/bubbles/bubble_9.tscn")
const BUBBLE_10_ENTITY = preload("res://entities/bubbles/bubble_10.tscn")

@export var Speed := 120

## Size is split into 10 discreet integers
const SIZE = 1

@export var Direction:= Vector2(0,0)

enum BUBBLE_SIZE {SIZE_1, SIZE_2, SIZE_3}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Direction = Vector2(1,1)
	getSize(1)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = position + (delta * Speed * Direction)
	pass

func getSize(size: float) -> void:
	var newBubble = BUBBLE_8_ENTITY.instantiate()
	add_child(newBubble)
