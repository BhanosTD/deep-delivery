extends Node
class_name DiveManager

@export var player: PlayerController;

var air_level: float = 1.0

signal player_flipped

func get_depth() -> float:
	return -player.position.y

func _process(delta):
	air_level -= delta / 60.0
	if air_level < 0:
		player.die()
