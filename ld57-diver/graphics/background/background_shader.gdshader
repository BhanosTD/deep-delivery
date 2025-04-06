shader_type sky;

uniform vec3 topColor : source_color;
uniform vec3 botColor : source_color;

vec3 cubemap() {
	return (topColor + botColor) / 2.0;
}

vec3 skyColor(vec2 uv) {
	return mix(topColor, botColor, uv.y);
}

void sky() {
    if (AT_CUBEMAP_PASS) {
        // Sets the radiance cubemap to a nice shade of blue instead of doing
        // expensive sky calculations
        COLOR = cubemap();
    } else {
        // Do expensive sky calculations for background sky only
        COLOR = skyColor(SKY_COORDS);
    }
}
