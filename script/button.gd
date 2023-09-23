extends Node2D


@export var BUTTON_TYPE := "PS_X"

func _ready():
	$AnimationPlayer.play(BUTTON_TYPE)
