extends CharacterBody2D


#Speed Controller
var MAX_SPEED = 400
var DASH_SPEED = 600    
var ACCELERATION = 200000
var DECELERATION = 200000
var dash_time = 0.0
var DASH_DURATION = 0.1


#Bubble Manager
const BubbleRoot = preload("res://entities/bubble.tscn")
var isChargingBubble = false
var bubbleRoot
var shootDirection

@export var Stun_Percentage = 0
@export var Stun_Timer = 0
@export var playerID = 0
var input_vector
signal on_player_stun(stun_percentage: float)

# PhysicsProcess manages player's speed
func _physics_process(delta: float) -> void:
	if Stun_Timer > 0:
		Stun_Timer -= 1
		return
	
	if playerID == 0:
		input_vector = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	if playerID == 1:
		input_vector = Input.get_vector("Controller_Left_1","Controller_Right_1","Controller_Up_1","Controller_Down_1")
	var direction = input_vector.normalized()
	var dash = "Dash_" + str(playerID)
	if Input.is_action_just_pressed(dash):
		dash_time = DASH_DURATION

	if dash_time > 0:
		dash_time -= delta

	var target_speed = MAX_SPEED
	if dash_time > 0:
		target_speed += DASH_SPEED

	if direction != Vector2.ZERO:
		if isChargingBubble:
			target_speed = 100
		var target_velocity = direction * target_speed
		velocity = velocity.move_toward(target_velocity, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, DECELERATION * delta)

	move_and_slide()

func hit(size: float) -> void:
	var damage = 0
	if size < 10:
		damage = 1;
	elif size < 20:
		damage = 2;
	elif size < 30:
		damage = 3;
	elif size < 40:
		damage = 4;
	elif size < 50:
		damage = 5
	elif size < 60:
		damage = 6;
	elif size < 70:
		damage = 7
	elif size < 80:
		damage = 8;
	elif size < 90:
		damage = 9
	else:
		damage = 10
	Stun_Percentage = clamp( Stun_Percentage + damage, 0, 300);
	if Stun_Timer <= 0:
		Stun_Timer = Stun_Percentage
	on_player_stun.emit(Stun_Percentage)

# Process manages player's Command
func _process(delta: float) -> void:
	var attack = "Attack_" + str(playerID)
	if Input.is_action_just_pressed(attack):
		bubbleRoot = BubbleRoot.instantiate()
		bubbleRoot.position = position
		get_tree().current_scene.add_child(bubbleRoot)
		bubbleRoot.createBubbleObject(1)
		isChargingBubble = true
	if(Input.is_action_just_released(attack) && bubbleRoot != null):
		bubbleRoot.Direction = shootDirection
		bubbleRoot.Shoot()
		isChargingBubble = false
		bubbleRoot = null
	if bubbleRoot != null && bubbleRoot.isShooted:
		bubbleRoot.Direction = shootDirection
		isChargingBubble = false
		bubbleRoot = null
		
	
	if isChargingBubble:
		bubbleRoot.position = position + Vector2(50,0)
		if input_vector == Vector2.ZERO:
			shootDirection = Vector2(1,0)
		else:
			shootDirection = input_vector
		bubbleRoot.SIZE += delta * 50
		bubbleRoot.Speed -= delta / 100
