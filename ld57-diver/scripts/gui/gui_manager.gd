extends Node

@export var dive_manager: DiveManager

func _process(delta):
	$"../DepthLabel".text = str(floor(dive_manager.get_depth())).replace(".0", "") + " m"
	$"../AirBar".value = dive_manager.air_level
