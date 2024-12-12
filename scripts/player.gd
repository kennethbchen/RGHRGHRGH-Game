extends Node2D

@onready var aim_system: AimSystem2D = $AimSystem2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	aim_system.aim_at_mouse()
	pass
