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
@export var SIZE = 1

@export var Direction:= Vector2(0,0)

var isShooted = false

var CurrentBubbleObject: Node

enum BUBBLE_SIZE {SIZE_1, SIZE_2, SIZE_3}

var ActiveTime: float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# createBubbleObject(90) # uncomment to test
	Direction = Vector2(1, 1)

	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if CurrentBubbleObject != getSize(SIZE):
		createBubbleObject(SIZE)
	ActiveTime += delta
	if isShooted:
		var sinedDirection := modifyBubbleDirection()
		position += (delta * Speed * sinedDirection)
	pass
	
func modifyBubbleDirection() -> Vector2:
	const amp: float = 2
	const freq: float = 5
	return Vector2(Direction.x, Direction.y + sin(ActiveTime * freq) * amp)
	pass
	
func getSize(size: float) -> PackedScene:
	if size <= 10:
		return BUBBLE_1_ENTITY
	elif size <= 20:
		return BUBBLE_2_ENTITY
	elif size <= 30:
		return BUBBLE_3_ENTITY
	elif size <= 40:
		return BUBBLE_4_ENTITY
	elif size <= 50:
		return BUBBLE_5_ENTITY
	elif size <= 60:
		return BUBBLE_6_ENTITY
	elif size <= 70:
		return BUBBLE_7_ENTITY
	elif size <= 80:
		return BUBBLE_8_ENTITY
	elif size <= 90:
		return BUBBLE_9_ENTITY
	elif size <= 100:
		return BUBBLE_10_ENTITY
	
	return BUBBLE_1_ENTITY


func createBubbleObject(size: float) -> void:
	var newBubble = getSize(size).instantiate()
	
	if CurrentBubbleObject:
		CurrentBubbleObject.queue_free()

	CurrentBubbleObject = newBubble
	add_child(newBubble)


func Shoot() -> void:
	isShooted = true
