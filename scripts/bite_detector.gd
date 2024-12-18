extends Area2D

class_name BiteDetector

signal bite_started()
signal bite_ended()
signal shaken()

var biteable = true

func is_enabled() -> bool:
	return biteable

func enable() -> void:
	biteable = true

func disable() -> void:
	biteable = false

func start_bite() -> void:
	bite_started.emit()
	
func end_bite() -> void:
	bite_ended.emit()

func shake() -> void:
	shaken.emit()
