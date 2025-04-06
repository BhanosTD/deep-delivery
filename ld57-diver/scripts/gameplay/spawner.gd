extends Node

@export var enemies: Array[PackedScene]
@export var dive_manager: DiveManager

func _ready():
	enemies[0].instantiate()

func spawn():
	var spawn_angle = randf_range(PI + 0.3, 2*PI - 0.3)
	
	var enemy = enemies[0].instantiate()
	enemy.global_position = dive_manager.player.position + Vector3(cos(spawn_angle), sin(spawn_angle), 0) * 20
	enemy.velocity = -Vector3(cos(spawn_angle), sin(spawn_angle), 0) * 4
	enemy.dive_manager = dive_manager
	
	get_parent().add_child(enemy);

func _on_dive_manager_player_flipped():
	if randf_range(0, 100) > 100 - 50 * atan(dive_manager.get_depth() / 20 - 4) / PI && dive_manager.get_depth() > 100:
		spawn()
