extends Node2D

@onready var aim_system: AimSystem2D = $AimSystem2D

@onready var hitbox: Area2D = $AimSystem2D/BiteArea

var bit_object: Node2D = null

# Transform that represents the transformation from global_transform -> bitten object's transform
var bite_relative_transform: Transform2D

func _ready() -> void:
	pass # Replace with function body.

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("game_bite"):
		_on_bite_clamp()
	elif event.is_action_released("game_bite"):
		_on_bite_release()

func _process(delta: float) -> void:
	aim_system.aim_at_mouse()
	rotation = aim_system.get_angle_change(rotation, delta)
	
	if bit_object:
		bit_object.global_transform = global_transform * bite_relative_transform
	

func _on_bite_clamp() -> void:
	
	if not bit_object and len(hitbox.get_overlapping_areas()) > 0:
		_bite_object(hitbox.get_overlapping_areas()[0])

func _on_bite_release() -> void:
	_release_bitten_object()

func _bite_object(obj: Node2D):
	
	if bit_object:
		return
		
	bit_object = obj
	bite_relative_transform = global_transform.affine_inverse() * obj.global_transform

func _release_bitten_object():
	if not bit_object:
		return
	
	bit_object = null
		
