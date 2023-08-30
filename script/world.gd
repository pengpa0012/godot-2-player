extends Node2D

const PLAYER_SCENE_PATH = preload("res://scenes/player.tscn")

var players = []

#func _ready():
#	Input.connect("joy_connection_changed", self, "_on_joy_connection_changed")
#
#
#func _on_joy_connection_changed(device_id, connected):
#	if connected:
#		print(Input.get_joy_name(device_id))
#	else:
#		print("Keyboard")

func _process(_delta):
	var connected_joypads = Input.get_connected_joypads()
	print(connected_joypads)
#	if connected_joypads.size() > 0:
#		var player_instance = PLAYER_SCENE_PATH.instantiate()
#		players.append(player_instance)
#		add_child(player_instance)
#
#		for i in range(players.size()):
#			players[i].position.x = i * 100 
	
