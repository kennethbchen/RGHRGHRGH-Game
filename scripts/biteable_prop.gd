extends CharacterBody2D

enum STATE {NORMAL, BITTEN, DESTROYED}

var current_state: STATE = STATE.NORMAL

var prev_rotation: float
var prev_position: Vector2

var angular_velocity: float = 0.0

var estimated_velocity: Vector2
var estimated_angular_velocity: float

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	
	match current_state:
		STATE.NORMAL:
			
			rotation += angular_velocity * delta
			
			move_and_slide()
			
		STATE.BITTEN:
			# Don't move and just be controlled by biter
			
			# Estimate velocity based on diff between prev and current position
			estimated_velocity = (position - prev_position) / delta
			prev_position = global_position
			
			# Estimate angular velocity
			estimated_angular_velocity = (rotation - prev_rotation) / delta
			prev_rotation = global_rotation
			
			return
	
func _on_bite_started() -> void:
	current_state = STATE.BITTEN
	velocity = Vector2.ZERO
	
func _on_bite_ended() -> void:
	current_state = STATE.NORMAL
	
	velocity = estimated_velocity
	angular_velocity = estimated_angular_velocity
