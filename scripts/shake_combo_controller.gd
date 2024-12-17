extends Node


@export var shake_combo_duration: float = 0.4

var last_shake_time: float = 0

var combo_active: bool = 0

signal shake_combo_started()
signal shake_combo_ended()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if Time.get_ticks_msec() - last_shake_time > shake_combo_duration * 1000:
		combo_active = false
		shake_combo_ended.emit()

func shake() -> void:
	
	if not combo_active:
		shake_combo_started.emit()
		combo_active = true
	
	
	last_shake_time = Time.get_ticks_msec()
