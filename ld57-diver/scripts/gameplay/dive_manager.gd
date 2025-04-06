extends Node
class_name DiveManager

@export var player: PlayerController;

var air_level: float = 1.0

var has_ended: bool = false

signal player_flipped

func get_depth() -> float:
	return -player.position.y * 2 + 10

func _process(delta):
	air_level -= delta / 60.0
	if air_level < 0:
		player.die()
	
	if get_depth() > 600 && !has_ended:
		has_ended = true
		var sub: Node3D = preload("res://graphics/background/submarine.glb").instantiate()
		sub.position = player.position + Vector3(0, -15, -5)
		sub.rotation.z = 0.2
		sub.rotation.y = -0.6
		
		get_parent().add_child(sub)
		
		var tween = create_tween()
		tween.tween_property(player, "position", sub.position + Vector3.BACK * 2, 2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
		
		await tween.finished
		
		GameStateManager.die()
