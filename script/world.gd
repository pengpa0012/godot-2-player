extends Node2D

const PLAYER_SCENE_PATH = preload("res://scenes/player.tscn")
@onready var display_size = get_viewport().get_visible_rect().size
var players = []
var colors = ["black", "blue"]


func _process(_delta):
	var connected_joypads = Input.get_connected_joypads()
	for player in connected_joypads:
		if player not in players:
			add_player(player)

func add_player(index):
	var randomize = randi_range(0, 1)
	players.append(index)  
	var player_instance = PLAYER_SCENE_PATH.instantiate()
	player_instance.position.x = randi_range(0, display_size.x)
	player_instance.player_index = index
	player_instance.player_color = colors[randomize]
	add_child(player_instance)
