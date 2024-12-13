extends Sprite2D

@export var sprite_atlas: AtlasTexture

@export var sprite_angle_thresholds: Array[float] = []

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
	
	var chosen_index: int = 0
	
	# Go through the list of angles in reverse order
	# Find the first angle that rot_degrees is greater than
	# That index is the index of the sprite atlas we should use
	for i in range(sprite_angle_thresholds.size() - 1, -1, -1):
		if abs(rot_degrees) >= sprite_angle_thresholds[i]:
			chosen_index = i
			break
	
	sprite_atlas.region.position = Vector2(chosen_index * sprite_size, 0)

	flip_h = rot_degrees >= 0
	
