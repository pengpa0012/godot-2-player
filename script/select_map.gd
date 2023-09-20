extends Control


func _on_button_3_button_down():
	get_tree().change_scene_to_file("res://scenes/world.tscn")


func _on_button_2_button_down():
	get_tree().change_scene_to_file("res://scenes/world_3.tscn")


func _on_button_button_down():
	get_tree().change_scene_to_file("res://scenes/world_2.tscn")
