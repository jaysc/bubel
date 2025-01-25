extends CharacterBody2D

var MAX_SPEED = 400
var DASH_SPEED = 600    
var ACCELERATION = 2000
var DECELERATION = 2000
var dash_time = 0.0
var DASH_DURATION = 0.2  # ダッシュが続く時間 (秒)


func _physics_process(delta: float) -> void:
	var input_vector = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	var direction = input_vector.normalized()

	# ダッシュ開始
	if Input.is_action_just_pressed("ui_select"):
		
		dash_time = DASH_DURATION

	# ダッシュ時間のカウントダウン
	if dash_time > 0:
		dash_time -= delta
		

	# 今回のフレームでの目標速度
	var target_speed = MAX_SPEED
	if dash_time > 0:
		# ダッシュ中は速度を上乗せ
		target_speed += DASH_SPEED

	if direction != Vector2.ZERO:
		var target_velocity = direction * target_speed
		velocity = velocity.move_toward(target_velocity, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, DECELERATION * delta)

	move_and_slide()

#var speed := 400

#func _physics_process(delta: float) -> void:
	#velocity = Input.get_vector("ui_left","ui_right","ui_up","ui_down") * speed
	#if Input.is_action_just_pressed("ui_select"):
		#velocity *= 100
	#move_and_slide()
