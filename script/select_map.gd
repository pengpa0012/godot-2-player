extends Control


func _on_button_3_button_down():
	print("pressing")
	get_tree().change_scene_to_file("res://scenes/world.tscn")
