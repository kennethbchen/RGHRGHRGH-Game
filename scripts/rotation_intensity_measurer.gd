extends Node2D

@export var min_shake_velocity: float = 30
@export var shake_cooldown_duration: float = 0.1

var prev_rotation: float
var prev_rotation_velocity: float

var shake_cooldown: bool = false

signal shake_occurred(clockwise: bool)

func _process(delta: float) -> void:
	
	prev_rotation_velocity = (global_rotation - prev_rotation) / delta
	prev_rotation = global_rotation
	
	if not shake_cooldown and abs(prev_rotation_velocity) > min_shake_velocity:
		
		shake_occurred.emit(prev_rotation_velocity <= 0)
		
		shake_cooldown = true
		var timer = get_tree().create_timer(shake_cooldown_duration)
		timer.timeout.connect(func(): shake_cooldown = false)
