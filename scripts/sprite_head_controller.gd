extends Sprite2D

@export var sprite_atlas: AtlasTexture

var sprite_size: int = 64
var num_sprites: int = 4

var center_angle_degrees: float = 0

# So, min angle is [center_angle - angle_extents] 
# and max angle is [center_angle + angle_extents]
var angle_extents_degrees: float = 80

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	texture = sprite_atlas
	
	texture.region.position = Vector2.ZERO
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	
	pass

func set_sprite_from_rotation(rot_degrees: float) -> void:
	
	var from = center_angle_degrees
	var to = from + angle_extents_degrees
	
	var ind: int = abs(inverse_lerp(from, to, rot_degrees) * (num_sprites - 1))
	ind = clamp(ind, -num_sprites - 1, num_sprites - 1)
	sprite_atlas.region.position = Vector2(ind * sprite_size, 0)
	
	print(ind)
	var flip: bool = rot_degrees >= 0

	flip_h = flip
	
	#global_rotation_degrees = clamp(rot_degrees, rot_degrees - angle_extents_degrees, rot_degrees + angle_extents_degrees )
	
