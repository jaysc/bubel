extends Node2D

@export var num_of_barrels = 4;

const BARREL = preload("res://entities/barrel.tscn")
const BARREL_SEPARATION = 75;

var BARRELS = []
var Barrel_Alive_Count = num_of_barrels

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for n in range(num_of_barrels):
		var barrel = BARREL.instantiate()
		barrel.position.y = BARREL_SEPARATION * n
		BARRELS.append(barrel)
		add_child(barrel)
		
func on_barrel_destroy() -> void:
	Barrel_Alive_Count -= 1
