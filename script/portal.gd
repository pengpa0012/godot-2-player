extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("default")


func _on_area_2d_body_entered(body):
	var portal =  get_tree().get_root().find_node("Portals")
	print(portal)
