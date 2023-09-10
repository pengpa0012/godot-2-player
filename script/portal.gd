extends Node2D

@onready var portal1 = get_node("/root/world/Portals/Portal")
@onready var portal2 = get_node("/root/world/Portals/Portal2")
@export var PORTAL = 1

func _ready():
	$AnimationPlayer.play("default")

func _on_area_2d_body_entered(body):
	if "Player" in body.name or "bullet" in body.name:
		if PORTAL == 1:
			body.global_position.x = portal2.global_position.x + 20
			body.global_position.y = portal2.global_position.y
		else:
			body.global_position.x = portal1.global_position.x - 20
			body.global_position.y = portal1.global_position.y
		

