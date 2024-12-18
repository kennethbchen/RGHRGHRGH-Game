extends Node2D

@onready var aim_system: AimSystem2D = $AimSystem2D

@onready var hitbox: Area2D = $BiteArea

@onready var sprite_head_controller: Sprite2D = $Head

@onready var rotation_intensity_measurer: Node2D = $RotationIntensityMeasurer

@onready var shake_combo_controller: Node = $ShakeComboController

@onready var particles: CPUParticles2D = $BiteParticles

@onready var sfx: AudioStreamPlayer = $SFXPlayer

var bit_object_detector: BiteDetector = null

# Transform that represents the transformation from global_transform -> bitten object's transform
var bite_relative_transform: Transform2D

func _ready() -> void:
	rotation_intensity_measurer.shake_occurred.connect(_on_shake_occurred)
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("game_bite"):
		_on_bite_clamp()
	elif event.is_action_released("game_bite"):
		_on_bite_release()

func _process(delta: float) -> void:
	aim_system.aim_at_mouse()
	rotation = aim_system.get_angle_change(rotation, delta)

	if bit_object_detector:
		bit_object_detector.get_parent().global_transform = global_transform * bite_relative_transform
	
	sprite_head_controller.set_sprite_from_rotation(global_rotation_degrees - 90)

func _on_bite_clamp() -> void:
	
	if not bit_object_detector and len(hitbox.get_overlapping_areas()) > 0 and \
		hitbox.get_overlapping_areas()[0] is BiteDetector:
		
		_bite_object(hitbox.get_overlapping_areas()[0])


func _on_bite_release() -> void:
	_release_bitten_object()

func _bite_object(obj: BiteDetector):
	
	if bit_object_detector:
		return
	
	if not obj.is_enabled():
		return
	
	bit_object_detector = obj
	bite_relative_transform = global_transform.affine_inverse() * obj.global_transform
	
	bit_object_detector.start_bite()
	
	sfx.play()
		
	particles.restart()
	particles.emitting = true
	
func _release_bitten_object():
	if not bit_object_detector:
		return
	
	bit_object_detector.end_bite()
	
	bit_object_detector = null

func _on_shake_occurred(clockwise: bool):
	# Player has rotated very fast
	
	if not bit_object_detector:
		return
	
	# Find the direction perpendicular to facing direction
	# And pointing left / right based on rotation direction
	var tangent = transform.x.rotated(PI/2 * 1 if clockwise else -1)
	
	EventBus.camera_shake_requested.emit(tangent * 40)
	
	shake_combo_controller.shake()
	bit_object_detector.shake()
