extends Node

func _process(delta):
	if Input.is_action_just_pressed("gameplay_flip"):
		GameStateManager.start()
		create_tween().tween_property($Camera3D, "start_pos", $Camera3D.start_pos - Vector3(0, 0.6, 0), 0.3)  
