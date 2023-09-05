extends Node2D

func _on_area_2d_body_entered(body):
	if "Player" in body.name:
		body.jump_boosted = true
		$AnimationPlayer.play("boost")
