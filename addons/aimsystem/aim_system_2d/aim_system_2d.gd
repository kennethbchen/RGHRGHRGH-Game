class_name AimSystem2D
extends Node2D

@export var enabled: bool = true

@export var rotate_self: bool = false

@export var aim_target: Node2D

@export var aim_speed: float = 30.0

var _target_global_position: Vector2

var _target_rotation_radians: float = 0

func init(target: Node2D):
	aim_target = target

func _process(delta):
	
	if not enabled:
		return
		
	if aim_target != null:
		aim_at(aim_target.global_position)

	if rotate_self:
		rotation = get_angle_change(rotation, delta)

func get_angle_change(rot: float, delta: float) -> float:
	return lerp_angle(rot, rot + _target_rotation_radians, aim_speed * delta)
	
func aim_at(global_pos: Vector2):
	_target_global_position = global_pos
	_target_rotation_radians = get_angle_to(_target_global_position)

func aim_at_mouse():
	aim_at(get_global_mouse_position())

func angle_error():
	return abs(_angle_dif(rotation, rotation + _target_rotation_radians))

func aim_direction() -> Vector2:
	return transform.x

# Returns angle in radians ranging from -PI to PI 
func _angle_dif(from : float, to : float):
	var ans = fposmod(to - from, TAU)
	
	if ans > PI:
		ans -= TAU
	return ans
