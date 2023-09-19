extends Node2D

const PLAYER_SCENE_PATH = preload("res://scenes/player.tscn")
@onready var display_size = get_viewport().get_visible_rect().size
var colors = ["black", "blue"]
@onready var GLOBAL = get_node("/root/Global")
@onready var counter = $Countdown/Label
var drop_players = false

func _process(_delta):
	var connected_joypads = Input.get_connected_joypads()
	counter.text = "[center]%s[/center]" % str(round($CountDownTimer.time_left))
	
	if $CountDownTimer.time_left <= 0:
		$Countdown.visible = false

	if drop_players:
		for player in connected_joypads:
			if player not in GLOBAL.players:
				add_player(player)

func add_player(index):
	var randomize = randi_range(0, 1)
	GLOBAL.players.append(index)  
	var player_instance = PLAYER_SCENE_PATH.instantiate()
	player_instance.position.x = randi_range(0, display_size.x - 100)
	player_instance.position.y = 50
	player_instance.player_index = index
	player_instance.player_color = colors[randomize]
	add_child(player_instance)


func _on_count_down_timer_timeout():
	drop_players = true
