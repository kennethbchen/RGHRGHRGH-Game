extends CharacterBody2D

enum STATE {NORMAL, BITTEN, DESTROYED}

@export var velocity_limit: float = 800

@export var angular_velocity_limit: float = 4

@export var erosion_levels: int = 10

@onready var sprite: Sprite2D = $Sprite2D

@onready var particles: CPUParticles2D = $CPUParticles2D

var current_state: STATE = STATE.NORMAL

var prev_rotation: float
var prev_position: Vector2

var angular_velocity: float = 0.0

var estimated_velocity: Vector2
var estimated_angular_velocity: float

var current_erosion_level: int = 0:
	set(value):
		current_erosion_level += 1
		current_erosion_level = clamp(current_erosion_level, 0, erosion_levels)

var particle_emit_start_time: float = 0

func _ready() -> void:
	
	sprite.material.set("shader_parameter/ErosionFactor", 0)
	
	particles.emitting = false

func _process(delta: float) -> void:
	
	# Only emit particles for a very short amount of time
	# This is better than using explosiveness because the particle can keep emitting
	# for multiple bursts
	if particles.emitting and Time.get_ticks_msec() - particle_emit_start_time > 50:
		particles.emitting = false
		
	velocity = velocity.limit_length(velocity_limit)
	angular_velocity = clamp(angular_velocity, -angular_velocity_limit, angular_velocity_limit)
	
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

func _on_shaken() -> void:
	
	current_erosion_level += 1
	var erosion_factor: float = (1.0 / erosion_levels) * current_erosion_level
	
	sprite.material.set("shader_parameter/ErosionFactor", erosion_factor)
	sprite.bump(estimated_velocity.normalized() * 35)
	
	_pulse_particles()
	
func _pulse_particles() -> void:
	
	particles.global_rotation = estimated_velocity.angle()
	
	particles.emitting = true
	particle_emit_start_time = Time.get_ticks_msec()


func _on_bite_started() -> void:
	current_state = STATE.BITTEN
	velocity = Vector2.ZERO
	
func _on_bite_ended() -> void:
	current_state = STATE.NORMAL
	
	velocity = estimated_velocity
	angular_velocity = estimated_angular_velocity
