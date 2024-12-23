shader_type canvas_item;

uniform vec2 direction = vec2(1, -0.74);
uniform float speed = 0.1;

void fragment() {

	COLOR = texture(TEXTURE, mod(UV + direction * speed * TIME, 1.0));
}
