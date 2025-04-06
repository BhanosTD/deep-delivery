extends Node

@export var dive_manager: DiveManager

@export_category("Background")
@export var background_mat: Material
@export var background_gradient: GradientTexture1D
@export var background_color_top: Color
@export var background_color_bot: Color

@export_category("Lighting")
@export var dir_light: DirectionalLight3D

func _process(delta):
	#background
	var background_blend = atan(dive_manager.get_depth() / 100) / PI * 2
	
	#background_mat.set_shader_parameter("topColor", lerp(background_color_top, Color.BLACK, background_blend))
	#background_mat.set_shader_parameter("botColor", lerp(background_color_bot, Color.BLACK, background_blend))
	
	background_mat.set_shader_parameter("topColor", background_gradient.gradient.sample(background_blend/2.0))
	background_mat.set_shader_parameter("botColor", background_gradient.gradient.sample(background_blend/2.0 + 0.5))

	#light
	dir_light.light_energy = 0.25 * (1 - background_blend)
