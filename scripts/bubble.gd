extends Node2D

@export var Speed := 60

## Size is split into 10 discreet integers
const SIZE = 1

@export var Direction:= Vector2(0,0)

enum BUBBLE_SIZE {SIZE_1, SIZE_2, SIZE_3}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Direction = Vector2(1,0.5)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = position + (delta * Speed * Direction)
	pass

func getSize(size: float) -> BUBBLE_SIZE:
	return BUBBLE_SIZE.SIZE_1
