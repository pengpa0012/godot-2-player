extends Node2D

const PLAYER_SCENE_PATH = preload("res://scenes/player.tscn")
@onready var display_size = get_viewport().get_visible_rect().size
var colors = ["black", "blue"]
@onready var GLOBAL = get_node("/root/Global")
@onready var counter = $Countdown/Label

func _process(_delta):
	counter.text = "[center]%s[/center]" % str(round($CountDownTimer.time_left))
	if len(GLOBAL.players) <= 1 and !$Countdown.visible:
		GLOBAL.players = []
		$Winner.visible = true
#		get_tree().change_scene_to_file("res://scenes/start_screen.tscn")
		
	if $CountDownTimer.time_left <= 0:
		$Countdown.visible = false

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
	var connected_joypads = Input.get_connected_joypads()	
	print(connected_joypads)
	for player in connected_joypads:
		if player not in GLOBAL.players:
			add_player(player)


func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/start_screen.tscn")
	$Winner.visible = false
