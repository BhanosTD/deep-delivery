extends Node3D

var start_pos: Vector3
var start_rot: Vector3
@export var noise: Noise
@export var strength: float = 1
@export var speed: float = 1

func _ready():
	start_pos = position
	start_rot = rotation

func _process(delta):
	position = start_pos + Vector3(0, noise.get_noise_1d(Time.get_ticks_msec() * 0.001 * speed) * strength, 0)
	
	rotation.z = start_rot.z + noise.get_noise_1d(Time.get_ticks_msec() * 0.001 * speed + 192489) * strength * 0.1
