extends CharacterBody2D


#Speed Controller
var MAX_SPEED = 400
var DASH_SPEED = 600    
var ACCELERATION = 200000
var DECELERATION = 200000
var dash_time = 0.0
var DASH_DURATION = 0.1


#Bubble Manager
signal shoot(bubble, direction, location)
const BubbleRoot = preload("res://entities/bubble.tscn")
var isChargingBubble = false

var bubbleRoot


# PhysicsProcess manages player's speed
func _physics_process(delta: float) -> void:
	var input_vector = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	var direction = input_vector.normalized()
	if Input.is_action_just_pressed("Dash"):

		dash_time = DASH_DURATION

	if dash_time > 0:
		dash_time -= delta

	var target_speed = MAX_SPEED
	if dash_time > 0:
		target_speed += DASH_SPEED

	if direction != Vector2.ZERO:
		var target_velocity = direction * target_speed
		velocity = velocity.move_toward(target_velocity, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, DECELERATION * delta)

	move_and_slide()


# Process manages player's Command
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Attack"):
		bubbleRoot = BubbleRoot.instantiate()
		add_child(bubbleRoot)
		bubbleRoot.createBubbleObject(1)
		isChargingBubble = true
	if(Input.is_action_just_released("Attack")):
		#remove_child(bubbleRoot)
		bubbleRoot.Direction = Vector2(1,0)
		print(bubbleRoot.Speed)
		bubbleRoot.Shoot()
		#shoot.emit(bubbleRoot,Vector2(1,0),bubbleRoot.position)
		isChargingBubble = false
		bubbleRoot = null
		
	
	if isChargingBubble:
		bubbleRoot.SIZE += delta * 100
		#bubbleRoot.Speed -= delta / 1