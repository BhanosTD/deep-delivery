shader_type spatial;

uniform vec3 waterColor: source_color;
uniform vec3 waterColorBot: source_color;
uniform sampler2D noise1;
uniform sampler2D noise1Normal: hint_normal;

varying vec2 uv;
varying vec2 uv2;

void vertex() {
	uv = UV + TIME * vec2(0.1, 0.8) * 0.001;
	uv2 = UV * 1.5 + TIME * vec2(-0.1, -0.8) * 0.005;
	
	VERTEX.y += (texture(noise1, uv).x - 0.5) * 0.5;
	VERTEX.y += (texture(noise1, uv2).x - 0.5) * 0.5;
	
	//NORMAL = (texture(noise1Normal, uv).xzy * INV_VIEW_MATRIX).rgb;
}

void fragment() {
	ALBEDO = vec3(texture(noise1, uv).w);
	ALBEDO = mix(waterColorBot, waterColor, (texture(noise1, uv).x + texture(noise1, uv2).x) / 2.0);
	SPECULAR = 0.02;
	ROUGHNESS = 0.2;
	
	NORMAL_MAP = (texture(noise1Normal, uv).xyz + texture(noise1Normal, uv2).xyz)/2.0;
	NORMAL_MAP_DEPTH = 0.2;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
