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

const KILL_MAX_X = 1000
const KILL_MAX_Y = 500

@export var Speed := 300

## Size is split into 10 discreet integers
@export var SIZE = 1

@export var Direction:= Vector2(0,0)

@export var isShooted = false

var CurrentBubbleObject: Node

enum BUBBLE_SIZE {SIZE_1, SIZE_2, SIZE_3}

var ActiveTime: float = 0

var random = RandomNumberGenerator.new()

var Can_Rebound := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !isShooted && CurrentBubbleObject != null:
		var spriteNode = get_child(0).get_node("Sprite2D")
		if spriteNode != null:
			var chargingSize = SIZE
			if (chargingSize >= 100):
				chargingSize = 100
			spriteNode.frame = ceil(chargingSize/10)
	ActiveTime += delta
	if SIZE > 100 && isShooted: #2.pop the bubble
		destroyBubble()
	if SIZE > 100 && !isShooted: #1. fource shoot the bubble and then pop it next frame
		Shoot()
	if isShooted:
		var sinedDirection := modifyBubbleDirection()
		position += (delta * Speed * sinedDirection)
	
	if position.x > KILL_MAX_X || position.x < -KILL_MAX_X || position.y > KILL_MAX_Y || position.y < -KILL_MAX_Y:
		destroyBubble()
		
func handle_rebound(rebound_direction: Vector2) -> void:
	if !Can_Rebound:
		return;

	var current_vector = Speed * Direction
	var rebound_strength = 1
	if SIZE < 3:
		rebound_strength = (1/SIZE) * 50
	elif SIZE < 5:
		rebound_strength = (1/SIZE) * 100
	else:
		rebound_strength = (1/SIZE) * 200
	var new_vector = current_vector + (rebound_direction * rebound_strength)
	Direction = new_vector.normalized()
	Speed = new_vector.length()
	
func modifyBubbleDirection() -> Vector2:
	var amp = random.randf_range(0,1)
	var freq = random.randf_range(4.0,6.0)
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
	print('rebound')
	get_tree().create_timer(1).connect("timeout", set_rebound)
	
func set_rebound() -> void:
	Can_Rebound = true

func destroyBubble() -> void:
	get_child(0).get_node("BubblePop").get_node("CPUParticles2D").emitting = true
	get_child(0).get_node("Sprite2D").frame = 10;
	await get_tree().create_timer(0.2).timeout 
	queue_free()
