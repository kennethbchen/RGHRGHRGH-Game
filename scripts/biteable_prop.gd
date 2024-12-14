extends CharacterBody2D

enum STATE {NORMAL, BITTEN, DESTROYED}

var current_state: STATE = STATE.NORMAL

func _ready() -> void:
	velocity = Vector2(0, -10)

func _process(delta: float) -> void:
	
	match current_state:
		STATE.NORMAL:
			move_and_slide()
		STATE.BITTEN:
			# Don't do anything and just be controlled by biter
			return
	
func _on_bite_started() -> void:
	current_state = STATE.BITTEN
	velocity = Vector2.ZERO
	
func _on_bite_ended() -> void:
	current_state = STATE.NORMAL
