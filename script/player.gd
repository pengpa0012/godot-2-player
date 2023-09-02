extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var player_index := 0 
  
func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if Input.is_joy_button_pressed(player_index, 0) and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	var left = Input.get_joy_axis(player_index, 0)
	var right = Input.get_joy_axis(player_index, 2)
	if left:
		velocity.x = left * SPEED
	elif right:
		velocity.x = right * SPEED		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
