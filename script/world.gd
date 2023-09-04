extends Node2D

const PLAYER_SCENE_PATH = preload("res://scenes/player.tscn")
@onready var display_size = get_viewport().get_visible_rect().size
var players = []


func _process(_delta):
	var connected_joypads = Input.get_connected_joypads()
	for player in connected_joypads:
		if player not in players:
			add_player(player)

func add_player(index):
	players.append(index)  
	var player_instance = PLAYER_SCENE_PATH.instantiate()
	player_instance.position.x = randi_range(0, display_size.x)
	player_instance.player_index = index
	add_child(player_instance)

func remove_player(index):
	players.erase(index)
