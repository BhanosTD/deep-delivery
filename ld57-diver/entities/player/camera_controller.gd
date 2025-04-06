extends Camera3D

@export var player: CharacterBody3D

func _process(delta):
	var target_position: Vector3 = player.position + Vector3.BACK * (10)
	
	position = lerp(position, target_position, 0.1)
