extends Node2D

# Based on https://kidscancode.org/godot_recipes/3.x/2d/screen_shake/index.html
# Assumes that this is parented to something with a true local position of (0,0)

@export var offset_decay: float = 10
@export var speed: float = 20

var cur_offset: Vector2

func _ready() -> void:
	pass

func _unhandled_input(event):
	
	if event.is_action_pressed("debug_bump_test"):
		bump(Vector2(0, 1) * 30) 

func _process(delta):
	
	if cur_offset.length() > 0:
		cur_offset = lerp(cur_offset, Vector2.ZERO, offset_decay * delta)
	
	position = lerp(position, cur_offset, speed * delta)
	
func bump(direction: Vector2):
	# Direction is in global coordinate space
	# Convert that to local space
	cur_offset += global_transform.basis_xform_inv(direction)
