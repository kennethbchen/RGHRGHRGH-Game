extends Node

@export var player: Node2D

@export var biteable_scene: PackedScene

@onready var biteable_parent: Node = $BiteableParent

@onready var spawn_area: CollisionShape2D = $SpawnArea

func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if biteable_parent.get_child_count() == 0:
		_create_new_biteable()
		
	pass

func _create_new_biteable():
	
	var obj: CharacterBody2D = biteable_scene.instantiate()
	
	biteable_parent.add_child(obj)
	
	obj.global_position = get_random_spawn_point()
	
	var dir_to_player: Vector2 = (player.global_position - obj.global_position).normalized()
	obj.velocity = dir_to_player * 64 * 6
	obj.angular_velocity = randf_range(-20, 20)

func get_random_spawn_point() -> Vector2:
	
	var rect: Rect2 = spawn_area.shape.get_rect()
	
	var x = randf_range(rect.position.x, rect.position.x + rect.size.x)
	var y = randf_range(rect.position.y, rect.position.y + rect.size.y)
	
	x += spawn_area.global_position.x
	y += spawn_area.global_position.y
	return Vector2(x, y)
