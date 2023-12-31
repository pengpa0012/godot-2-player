extends CharacterBody2D
const SPEED = 180.0
const JUMP_VELOCITY = -350.0

@onready var bullet = preload("res://scenes/bullet.tscn")
@export var player_index := 0
@export var jump_boosted = false
@onready var playerParry = $Sprite2D/Shield
@onready var playerMarker = $Sprite2D/Marker2D
@export var player_color = "black"
@export var is_dead = false
@onready var display_size = get_viewport().get_visible_rect().size
@onready var GLOBAL = get_node("/root/Global")

var player_data = {
	"health": 10,
	"life": 3,
	"gravity": ProjectSettings.get_setting("physics/2d/default_gravity"),
	"faceRight": true,
	"canShoot": false,
	"bullet": 5
}
var jump_pressed = false
var parry_pressed = false
  
func _physics_process(delta):
	$Ammo.set_frame(5 - player_data["bullet"])
	$Shieldbar.value = 100 - ($ParryTimer.time_left / 5 * 100)
	if is_dead:
		if !$SFX/death.playing:
			$SFX/death.play()				
		$Healthbar.value = 0		
		$AnimationPlayer.play(player_color + "_death")
		return
		
	if not is_on_floor():
		velocity.y += player_data["gravity"] * delta
	if Input.is_joy_button_pressed(player_index, 1) and not parry_pressed and $ParryTimer.time_left <= 0:
		$AnimationPlayer2.play("parry")
		parry_pressed = true
		button_pressed_once(false)

	if Input.is_joy_button_pressed(player_index, 0) and not jump_pressed and is_on_floor():
		jump_pressed = true
		button_pressed_once(true)
		
	if not Input.is_joy_button_pressed(player_index, 1):
		parry_pressed = false
		
	if not Input.is_joy_button_pressed(player_index, 0):
		jump_pressed = false

	var directionX = Input.get_joy_axis(player_index, 0)
	var directionY = Input.get_joy_axis(player_index, 1)
	
	if player_data["health"] <= 0:
		if !$SFX/death.playing:
			$SFX/death.play()
		$AnimationPlayer.play(player_color + "_death")
	else:
		if directionX:
			if is_on_floor():
				$AnimationPlayer.play(player_color + "_run")		
			if directionX > 0:
				$Sprite2D.scale.x = 1.136
				playerMarker.position.x = 25
				player_data["faceRight"] = true
			else:
				$Sprite2D.scale.x = -1.136
				player_data["faceRight"] = false
			velocity.x = directionX * SPEED
		else:
			if is_on_floor():
	#			if directionY:
	#				$AnimationPlayer.play("crouch")
	#			else:
				$AnimationPlayer.play(player_color + "_idle")
			velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if not is_on_floor():
		$AnimationPlayer.play(player_color + "_jump")
	
	if Input.is_joy_button_pressed(player_index, 2):
		if player_data["bullet"] <= 0 and $BulletTimer.time_left <= 0:
			$BulletTimer.start()
			
		if !player_data["canShoot"] and player_data["bullet"] > 0:
			player_data["canShoot"] = true     
			shoot() 
	else:
		player_data["canShoot"] = false

	move_and_slide()
	
func button_pressed_once(isJump):
	if isJump:
		velocity.y = JUMP_VELOCITY
	else:
#		playerParry.visible = true
		$ParryTimer.start()
	
func shoot():
	$SFX/shoot.play()
	var newBullet = bullet.instantiate()
	newBullet.position = playerMarker.global_position
	newBullet.faceRight = player_data["faceRight"]
	player_data["bullet"] -= 1
	get_parent().add_child(newBullet)
	
func player_hurt(amount):
	$Healthbar.value -= 10
	$SFX/hurt.play()
	player_data["health"] -= amount
	
func _on_animation_player_animation_finished(anim_name):
	if "death" in anim_name:
		player_data["life"] -= 1
		if player_data["life"] <= 0:
			queue_free()
			GLOBAL.players.remove_at(player_index)						
		else:
			is_dead = false
			player_data["health"] = 10
			$Healthbar.value = 100
			self.position.x = randi_range(0, display_size.x)
			self.position.y = 10
	if "parry" in anim_name:
		player_data["parry"] = false

func _on_bullet_timer_timeout():
	player_data["bullet"] = 5

func _on_shield_collision_area_entered(area):
#	if "bulletCollision" in area.name:
	pass


func _on_area_2d_body_entered(body):
	if "MovingPlatform" in body.name:
		velocity.x = body.velocity.x



func _on_parry_timer_timeout():
	$ParryTimer.stop()
	pass
#	playerParryCollision.disabled = true	
#	playerParry.visible = false
