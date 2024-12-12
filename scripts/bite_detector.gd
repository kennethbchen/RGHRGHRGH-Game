extends Area2D

class_name BiteDetector

signal bite_started()
signal bite_ended()

func start_bite() -> void:
	bite_started.emit()
	
func end_bite() -> void:
	bite_ended.emit()
