extends Node

@export var transition_cover: Control

var is_transitioning: bool = false

var last_score: int = -1
var high_score: int = -1

func _process(delta):
	if is_transitioning:
		return
	
	$ColorRect.position.y = $ColorRect.size.y

func load_level(scene: String):
	is_transitioning = true
	$ColorRect.position.y = $ColorRect.size.y
	
	var tween = create_tween()
	tween.tween_property($ColorRect, "position", Vector2(0, 0), 0.3)\
		.set_trans(Tween.TRANS_CUBIC)\
		.set_ease(Tween.EASE_IN)
	
	await tween.finished
	
	get_tree().change_scene_to_file(scene)
	
	await get_tree().process_frame
	#.create_timer(0.1).timeout
	
	tween = create_tween()
	tween.tween_property($ColorRect, "position", Vector2(0, -$ColorRect.size.y), 0.3)\
		.set_trans(Tween.TRANS_CUBIC)\
		.set_ease(Tween.EASE_OUT)
		
	await get_tree().process_frame
	is_transitioning = false

func start():
	load_level("uid://b8a8mnvh4oksu")

func die():
	last_score = -1
	
	load_level("uid://w121ex5u488e")
	

func finish(score: int):
	last_score = score
	if last_score > high_score:
		high_score = last_score
	
	load_level("uid://w121ex5u488e")
