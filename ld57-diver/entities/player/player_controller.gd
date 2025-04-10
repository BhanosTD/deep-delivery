extends CharacterBody3D
class_name PlayerController

var graphicsRoot: Node3D
var camera: Camera3D
@export var dive_manager: DiveManager
var flip_stage: int = 0

var flip_cooldown = 0.0

func get_world_mouse_pos() -> Vector3:
	var mouse_pos: Vector2 = camera.get_viewport().get_mouse_position()
	
	var normal_mult: float = - camera.project_ray_origin(mouse_pos).z / camera.project_local_ray_normal(mouse_pos).z
	
	return camera.project_ray_origin(mouse_pos) + camera.project_local_ray_normal(mouse_pos) * normal_mult

func _ready():
	graphicsRoot = $GraphicsRoot
	camera = $"../Camera3D"
	
	$GraphicsRoot/InnerRotator/Diver/AnimationPlayer.play("Flip2")
	

func _process(delta):
	rotation.z = atan2(get_world_mouse_pos().y - position.y, get_world_mouse_pos().x - position.x)

func _physics_process(delta):
	if dive_manager.has_ended || !visible:
		return
	
	velocity *= 0.96
	
	var has_flipped: bool = false
	
	if Input.is_action_just_pressed("gameplay_flip_" + str(flip_stage + 1)) && flip_cooldown < 0:
		has_flipped = true
		$GraphicsRoot/InnerRotator/Diver/AnimationPlayer.play("Flip" + str(flip_stage + 1))
		flip_stage += 1
		flip_stage = flip_stage % 2 
		flip_cooldown = 0.2
	
	if has_flipped:
		velocity += 10 * Vector3(get_world_mouse_pos().x - position.x, get_world_mouse_pos().y - position.y, 0).normalized()
		dive_manager.player_flipped.emit()
	
	position.y -= delta
	
	position.y = min(0, position.y)
	
	flip_cooldown -= delta
	
	move_and_slide()

func die():
	hide()
	await get_tree().create_timer(1).timeout
	GameStateManager.die()
