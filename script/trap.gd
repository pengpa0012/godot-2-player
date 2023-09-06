extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("default")


func _on_area_2d_body_entered(body):
	if "Player" in body.name:
		body.queue_free()
