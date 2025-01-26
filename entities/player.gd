extends CharacterBody2D

#sprites
const choonkSprite = preload("res://assets/characters/CharChoonk.png")
const slimeSprite = preload("res://assets/characters/CharSlimelordz.png")
const nagainuSprite = preload("res://assets/characters/CharNagainu.png")
const shiroumaSprite = preload("res://assets/characters/CharShirouma.png")
const spriteArr = [choonkSprite, slimeSprite, nagainuSprite, shiroumaSprite]
var spritePointer = 0

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
var isDefending = false
var bubbleRoot
var shootDirection: Vector2
var clampedDirection = 0

@export var Stun_Percentage = 0
@export var Stun_Timer = 0
@export var playerID = 0
var input_vector
signal on_player_stun(stun_percentage: float)

var STOP_TIMER = 0
var Attack_Cooldown_Timer: float = 0

func _ready() -> void:
	spritePointer = playerID
	#flip player 2
	if playerID == 1:
		$Sprite2D.flip_h = !$Sprite2D.flip_h

# PhysicsProcess manages player's speed
func _physics_process(delta: float) -> void:
	stunBubbleProcess();
	if Stun_Timer > 0:
		Stun_Timer -= 1
		return
	if Attack_Cooldown_Timer > 0:
		Attack_Cooldown_Timer -= delta
	if STOP_TIMER > 0:
		STOP_TIMER -= 1
		return
		
	if playerID == 0:
		input_vector = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	if playerID == 1:
		input_vector = Input.get_vector("Controller_Left_1","Controller_Right_1","Controller_Up_1","Controller_Down_1")
	var direction = input_vector.normalized()
	var dash = "Dash_" + str(playerID)
	if Input.is_action_just_pressed(dash):
		dash_time = DASH_DURATION
	var charShuffle = "CharacterShuffle_" + str(playerID)
	if Input.is_action_just_pressed(charShuffle):
		spritePointer += 1
		if spritePointer > 3:
			spritePointer = 0
		$Sprite2D.texture = spriteArr[spritePointer]

	if dash_time > 0:
		dash_time -= delta

	var target_speed = MAX_SPEED
	if dash_time > 0:
		target_speed += DASH_SPEED
		
	var final_to := Vector2()
	var final_delta := 0
	
	handle_defending()
	
	if direction != Vector2.ZERO:
		# Player is moving a direction
		if isChargingBubble || isDefending:
			target_speed = 10
		final_to = direction * target_speed
		final_delta = ACCELERATION * delta
	else:
		final_to = Vector2.ZERO
		final_delta = DECELERATION * delta

	velocity = velocity.move_toward(final_to, final_delta)

	move_and_slide()

func handle_defending() -> void:
	var defense = "Defense_" + str(playerID)
	isDefending = Input.is_action_pressed(defense)
	if isDefending:
		$BubbleBlowaway.get_node("CPUParticles2D").emitting = true
		$BubbleBlowaway/CPUParticles2D.direction = clampedDirection
	else:
		$BubbleBlowaway.get_node("CPUParticles2D").emitting = false

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
		if damage > 1:
			damage = damage / 2
		Stun_Timer = damage * Stun_Percentage
	on_player_stun.emit(Stun_Percentage)

# Process manages player's Command
func _process(delta: float) -> void:
	var attack = "Attack_" + str(playerID)
	if Input.is_action_just_pressed(attack) && Attack_Cooldown_Timer <= 0:
		bubbleRoot = BubbleRoot.instantiate()
		bubbleRoot.position = position
		get_tree().current_scene.add_child(bubbleRoot)
		bubbleRoot.createBubbleObject(1)
		isChargingBubble = true
	if(Input.is_action_just_released(attack) && bubbleRoot != null && Attack_Cooldown_Timer <= 0):
		bubbleRoot.Direction = clampedDirection
		Attack_Cooldown_Timer = 0.5 - min(bubbleRoot.SIZE/100, 1)
		bubbleRoot.Shoot()
		STOP_TIMER = 2
		isChargingBubble = false
		bubbleRoot = null
	if bubbleRoot != null && bubbleRoot.isShooted:
		Attack_Cooldown_Timer = 0.5 - min(bubbleRoot.SIZE/100, 1)
		bubbleRoot.Direction = clampedDirection
		isChargingBubble = false
		bubbleRoot = null
	
	if input_vector == Vector2.ZERO:
		shootDirection = Vector2(1,0) if playerID == 0 else Vector2(-1,0)
	else:
		shootDirection = input_vector
		
	var clampedInputRad =  clamp(shootDirection.angle(),-1,1) if playerID == 0 else clamp(Vector2(-1,0).angle_to(shootDirection),-1,1)
	clampedDirection = Vector2.RIGHT.rotated(clampedInputRad) if playerID == 0 else Vector2.LEFT.rotated(clampedInputRad)

	if isChargingBubble && bubbleRoot != null:
		bubbleRoot.position = position + Vector2(50,0)
		bubbleRoot.position = position + clampedDirection * 80
		bubbleRoot.SIZE += delta * 50
		bubbleRoot.Speed -= delta / 1000

func stunBubbleProcess() -> void:
	var stunBubble = get_node("BubbleStun")
	var collider = get_node("Area2D")
	if Stun_Timer > 0 && !stunBubble.visible:
		Attack_Cooldown_Timer = 100
		set_collision_layer_value(1, false)
		set_collision_mask_value(1, false)
		collider.set_collision_layer_value(1, false)
		collider.set_collision_mask_value(1, false)
		stunBubble.visible = true
	if Stun_Timer <= 0 && stunBubble.visible:
		stunBubble.visible = false
		Attack_Cooldown_Timer = 0
		await get_tree().create_timer(1).timeout #invincible time
		set_collision_layer_value(1, true)
		set_collision_mask_value(1, true)
		collider.set_collision_layer_value(1, true)
		collider.set_collision_mask_value(1, true)
	
