extends Node

# Based on https://kidscancode.org/godot_recipes/3.x/2d/screen_shake/index.html

@export var offset_decay: float = 10
@export var camera_speed: float = 20
@onready var camera = $".."

var offset: Vector2

func _ready() -> void:
	EventBus.camera_shake_requested.connect(bump)

func _unhandled_input(event):
	
	if event.is_action_pressed("debug_bump_test"):
		bump(Vector2(randf_range(-1,1), randf_range(-1,1)) * 30) 

func _process(delta):
	
	if offset.length() > 0:
		offset = lerp(offset, Vector2.ZERO, offset_decay * delta)
	
	camera.offset = lerp(camera.offset, offset, camera_speed * delta)
	
func bump(direction: Vector2):
	offset += direction
