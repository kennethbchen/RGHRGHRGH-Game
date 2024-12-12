extends Node2D

@onready var aim_system: AimSystem2D = $AimSystem2D

@onready var hitbox: Area2D = $AimSystem2D/BiteArea

var bit_object: Node2D = null
var bite_position_offset: Vector2

func _ready() -> void:
	pass # Replace with function body.

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("game_bite"):
		_on_bite_clamp()
	elif event.is_action_released("game_bite"):
		_on_bite_release()

func _process(delta: float) -> void:
	aim_system.aim_at_mouse()

func _on_bite_clamp() -> void:
	
	if len(hitbox.get_overlapping_areas()) > 0:
		bite_object(hitbox.get_overlapping_areas()[0])

func _on_bite_release() -> void:
	pass


func bite_object(obj: Node2D):
	print(obj)
