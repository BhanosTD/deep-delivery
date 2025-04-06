extends CharacterBody3D

@export var dive_manager: DiveManager
@export var animation_player: AnimationPlayer

var wariness: float = 0.0

var chasing: bool

func _ready():
	dive_manager.player_flipped.connect(_on_player_fliped)
	%KillArea.body_entered.connect(on_body_entered)

func _physics_process(delta):
	if !dive_manager:
		return
	
	if wariness > 1:
		velocity = lerp(velocity, (dive_manager.player.position - position).normalized() * 32, 0.05)
		animation_player.play("SwimAttack")
	else:
		velocity = velocity.normalized() * 4
		animation_player.play("Swim")
		
	$GraphicsRoot.rotation.z = atan2(velocity.y, velocity.x) 
	
	animation_player.speed_scale = velocity.length() / 3
	
	print(wariness)
	wariness -= delta
	wariness = clamp(wariness, 0, 2)
	move_and_slide()

func _on_player_fliped():
	if !dive_manager:
		return
	
	wariness += 1 * (1 - atan(position.distance_to(dive_manager.player.position) * 0.02) / PI * 2)

func on_body_entered(body: Node3D):
	if body is PlayerController:
		body.die()
