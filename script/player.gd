extends CharacterBody2D
const SPEED = 180.0
const JUMP_VELOCITY = -350.0

@onready var bullet = preload("res://scenes/bullet.tscn")
@export var player_index := 0
@export var jump_boosted = false
@onready var playerShield = $Sprite2D/Shield
@onready var playerShieldCollision = $Sprite2D/Shield/shieldCollision/CollisionShape2D
@onready var playerMarker = $Sprite2D/Marker2D
@export var player_color = "black"
@export var is_dead = false
@onready var display_size = get_viewport().get_visible_rect().size

var player_data = {
	"health": 3,
	"life": 3,
	"gravity": ProjectSettings.get_setting("physics/2d/default_gravity"),
	"faceRight": true,
	"canShoot": false,
	"bullet": 3
}
var jump_pressed = false
var shield_pressed = false
  
func _physics_process(delta):
	if is_dead:
		$AnimationPlayer.play(player_color + "_death")
		return
		
	if not is_on_floor():
		velocity.y += player_data["gravity"] * delta

	if Input.is_joy_button_pressed(player_index, 1) and not shield_pressed:
		shield_pressed = true
		button_pressed_once(false)		

	if Input.is_joy_button_pressed(player_index, 0) and not jump_pressed and is_on_floor():
		jump_pressed = true
		button_pressed_once(true)
		
	if not Input.is_joy_button_pressed(player_index, 1):
		shield_pressed = false
		
	if not Input.is_joy_button_pressed(player_index, 0):
		jump_pressed = false

	var directionX = Input.get_joy_axis(player_index, 0)
	var directionY = Input.get_joy_axis(player_index, 1)
	
	if player_data["health"] <= 0:
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
		playerShield.visible = true
		playerShieldCollision.disabled = false
		$ShieldTimer.start()
	
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
		player_data["life"] -= 1
		if player_data["life"] <= 0:
			queue_free()
		else:
			is_dead = false
			player_data["health"] = 3
			self.position.x = randi_range(0, display_size.x)
			self.position.y = 10
	if "parry" in anim_name:
		player_data["shield"] = false

func _on_bullet_timer_timeout():
	player_data["bullet"] = 3


func _on_shield_timer_timeout():
	playerShieldCollision.disabled = true	
	playerShield.visible = false

func _on_shield_collision_area_entered(area):
#	if "bulletCollision" in area.name:
	pass


func _on_visible_on_screen_enabler_2d_screen_exited():
	# add player killed here on screen exit
	pass
