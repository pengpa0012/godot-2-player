extends Node2D
var speed = 1000
var faceRight = true

func _ready():
	$AnimationPlayer.play("regular_bullet")
	
func _process(delta):
	if faceRight:
		self.position.x += speed * delta
	else:
		self.position.x -= speed * delta		


func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()


func _on_area_2d_body_entered(body):
	if "Player" in body.name:
		queue_free()
		body.player_hurt(1)
