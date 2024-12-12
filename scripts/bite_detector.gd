extends Area2D

class_name BiteDetector

@onready var hurtbox: Area2D = $Hurtbox

signal bite_started()
signal bite_ended()

func start_bite() -> void:
	bite_started.emit()
	
func end_bite() -> void:
	bite_ended.emit()
