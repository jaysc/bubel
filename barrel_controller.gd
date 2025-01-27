extends Node2D

@export var num_of_barrels = 5;

const BARREL = preload("res://entities/barrel.tscn")
const BARREL_SEPARATION = 85;
var Health = 100;

var BARRELS = []
var Barrel_Alive_Count = num_of_barrels

signal barrel_group_hit(health: float)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for n in range(num_of_barrels):
		var barrel = BARREL.instantiate()
		barrel.position.y = BARREL_SEPARATION * n
		BARRELS.append(barrel)
		add_child(barrel)
		
func on_barrel_destroy() -> void:
	pass
		
func on_barrel_hit(damage: float) -> void:
	Health -= damage
	barrel_group_hit.emit(Health)
