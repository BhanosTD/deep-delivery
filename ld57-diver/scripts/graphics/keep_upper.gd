extends Node3D

var actual_rotation: float = 0

func _process(delta):
	var rot_target: float = 0
	
	if get_parent().global_basis.y.y < 0:
		rot_target = PI
	
	actual_rotation = lerp(actual_rotation, rot_target, 0.1)
	
	rotation.x = actual_rotation
