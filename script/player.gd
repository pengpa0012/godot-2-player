extends CharacterBody2D
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var bullet = preload("res://scenes/bullet.tscn")
@export var player_index := 0 

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var faceRight = true
  
func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	
#	if Input.is_joy_button_pressed(player_index, 0) and is_on_floor():
#		velocity.y = JUMP_VELOCITY
#
#	var left = Input.get_joy_axis(player_index, 0)
#	var right = Input.get_joy_axis(player_index, 2)
#	if left:
#		velocity.x = left * SPEED
#	elif right:
#		velocity.x = right * SPEED		
#	else:
#		velocity.x = move_toward(velocity.x, 0, SPEED)

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_just_pressed("shoot"):
		shoot()
		
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		if direction > 0:
			$Marker2D.position.x = 50
			faceRight = true
		else:
			$Marker2D.position.x = -50
			faceRight = false
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func shoot():
	var newBullet = bullet.instantiate()
	newBullet.position = $Marker2D.global_position
	newBullet.faceRight = faceRight
	get_parent().add_child(newBullet)
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
