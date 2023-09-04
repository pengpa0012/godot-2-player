extends CharacterBody2D
const SPEED = 250.0
const JUMP_VELOCITY = -350.0

@onready var bullet = preload("res://scenes/bullet.tscn")
@export var player_index := 0
@onready var playerShield = $Sprite2D/Shield
@onready var playerMarker = $Sprite2D/Marker2D

var player_data = {
	"health": 3,
	"gravity": ProjectSettings.get_setting("physics/2d/default_gravity"),
	"faceRight": true,
	"canShoot": false,
	"canJump": false,
	"jumpPressed": false,
	"shield": false,
	"bullet": 3
}

  
func _physics_process(delta):
	if not is_on_floor():
		velocity.y += player_data["gravity"] * delta
	
	var jump_button_pressed_now = Input.is_joy_button_pressed(player_index, 0)
	if jump_button_pressed_now and is_on_floor() and not player_data["jumpPressed"] and player_data["canJump"]:
		velocity.y = JUMP_VELOCITY
		player_data["canJump"] = false 

	player_data["jumpPressed"] = jump_button_pressed_now
	
#	if Input.is_joy_button_pressed(player_index, 1):
#		playerShield.visible = true
#		await get_tree().create_timer(.5).timeout
#		playerShield.visible = false		
		
	if is_on_floor():
		player_data["canJump"] = true

	var directionX = Input.get_joy_axis(player_index, 0)
	var directionY = Input.get_joy_axis(player_index, 1)
	
	if player_data["health"] <= 0:
		$AnimationPlayer.play("death")
	else:
		if directionX:
			if is_on_floor():
				$AnimationPlayer.play("run")		
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
				$AnimationPlayer.play("idle")
			velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if not is_on_floor():
		$AnimationPlayer.play("jump")
	
	if Input.is_joy_button_pressed(player_index, 2):
		if player_data["bullet"] <= 0 and $BulletTimer.time_left <= 0:
			$BulletTimer.start()
			
		if !player_data["canShoot"] and player_data["bullet"] > 0:
			player_data["canShoot"] = true     
			shoot() 
	else:
		player_data["canShoot"] = false

	move_and_slide()

func shoot():
	var newBullet = bullet.instantiate()
	newBullet.position = playerMarker.global_position
	newBullet.faceRight = player_data["faceRight"]
	player_data["bullet"] -= 1
	get_parent().add_child(newBullet)
	
func player_hurt(amount):
	player_data["health"] -= amount
	
func _on_animation_player_animation_finished(anim_name):
	if "death" in anim_name:
		queue_free()
	if "parry" in anim_name:
		player_data["shield"] = false

func _on_bullet_timer_timeout():
	player_data["bullet"] = 3
	print("reload")
