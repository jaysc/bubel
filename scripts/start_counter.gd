extends Node2D

var isCounting = false
var count = 4.0

@export var GameManager : Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	StartCount()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if isCounting:
		count -= delta
		var intCount = int(count)
		if intCount >= 1:
			get_node("Label").text = str(intCount)
		if(intCount < 1):
			get_node("Label").text = "START"
		if(intCount < 0 ):
			get_node("Label").text = ""
			isCounting = false
	#temp way of displaying game over
	if GameManager.Player_1_Goal_Health <= 0 || GameManager.Player_2_Goal_Health <= 0:
		EndGame()

func StartCount() -> void:
	isCounting = true
	GameManager.STOP_TIMER = count

func EndGame() -> void:
	get_node("Label").text = "GAME OVER"
	GameManager.STOP_TIMER = 100
	GameManager.Game_Over = true
