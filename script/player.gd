extends CharacterBody2D
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var bullet = preload("res://scenes/bullet.tscn")
@export var player_index := 0 

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var faceRight = true
var canShoot = false
  
func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if Input.is_joy_button_pressed(player_index, 0) and is_on_floor():
		velocity.y = JUMP_VELOCITY
				
	var directionX = Input.get_joy_axis(player_index, 0)
	var directionY = Input.get_joy_axis(player_index, 1)
	
	if directionX:
		if is_on_floor():
			$AnimationPlayer.play("run")		
		if directionX > 0:
			$Sprite2D.flip_h = false
			$Marker2D.position.x = 18
			faceRight = true
		else:
			$Sprite2D.flip_h = true
			$Marker2D.position.x = -18
			faceRight = false
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

#	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
#		velocity.y = JUMP_VELOCITY
#
	
	if Input.is_joy_button_pressed(player_index, 2):
		if !canShoot:
			canShoot = true      
			shoot()  # do button pressed processing here 
	else:
		canShoot = false
#
#	var directionX = Input.get_axis("ui_left", "ui_right")
#	if directionX:
#		if is_on_floor():
#			$AnimationPlayer.play("run")		
#		if directionX > 0:
#			$Sprite2D.flip_h = false
#			$Marker2D.position.x = 18
#			faceRight = true
#		else:
#			$Sprite2D.flip_h = true
#			$Marker2D.position.x = -18
#			faceRight = false
#		velocity.x = directionX * SPEED
#	else:
#		if is_on_floor():
#			$AnimationPlayer.play("idle")		
#		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func shoot():
	var newBullet = bullet.instantiate()
	newBullet.position = $Marker2D.global_position
	newBullet.faceRight = faceRight
	get_parent().add_child(newBullet)
	
#func _on_animation_player_animation_finished(anim_name):
#	if anim_name == "crouch":
#		$AnimationPlayer.stop()
