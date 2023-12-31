extends Node2D
var speed = 1000
var faceRight = true
var parried = false

func _ready():
	$AnimationPlayer.play("bullet_regular")
	
func _process(delta):
	if faceRight:
		self.position.x += speed * delta
	else:
		self.position.x -= speed * delta		


func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()

func _on_bullet_collision_body_entered(body):
	if "Portal" in body.name or "bullet" in body.name:
		return
	else:
		queue_free()	
		if "Player" in body.name:
			body.player_hurt(1)


func _on_bullet_collision_area_entered(area):
	if "shieldCollision" in area.name:
		$SFX/parry.play()
		if area.global_position.x < self.global_position.x:
			faceRight = true
			print("RIGGHT")
		else:
			faceRight = false
			print("LEFT")			
	elif "bullet" in area.name:
		queue_free()
