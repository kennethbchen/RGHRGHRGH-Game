@tool
extends EditorPlugin


func _enter_tree():
	add_custom_type("AimSystem2D", "Node2D", preload("aim_system_2d/aim_system_2d.gd"), preload("res://addons/aimsystem/aim_system_2d/AimSystem2D.svg"))
	
func _exit_tree():
	remove_custom_type("AimSystem2D")
