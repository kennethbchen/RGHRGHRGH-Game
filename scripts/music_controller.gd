extends AudioStreamPlayer
	
func _ready() -> void:
	playing = true
	stream_paused = true
	
func _on_shake_combo_started() -> void:
	stream_paused = false

func _on_shake_combo_ended() -> void:
	stream_paused = true
