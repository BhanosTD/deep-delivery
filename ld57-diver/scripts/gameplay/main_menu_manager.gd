extends Node

func _ready():
	if GameStateManager.last_score >= 0:
		$GUI/Congrats.text = "Woah, you did it! With " + str(GameStateManager.last_score) + "% of air left in your tank no less, impressive! Congrats!"
	else:
		$GUI/Congrats.hide()
	
	if GameStateManager.high_score >= 0:
		$GUI/HS.text = "Session high score: " + str(GameStateManager.high_score)

func _process(delta):
	if Input.is_action_just_pressed("gameplay_flip"):
		GameStateManager.start()
		create_tween().tween_property($Camera3D, "start_pos", $Camera3D.start_pos - Vector3(0, 0.6, 0), 0.3)  
