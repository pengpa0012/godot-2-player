extends Node2D
@export var JUMP_FORCE = -600

func _on_area_2d_body_entered(body):
	if "Player" in body.name:
		body.velocity.y = JUMP_FORCE
		$AnimationPlayer.play("boost")
