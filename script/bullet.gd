extends Node2D
var speed = 700
var faceRight = true
func _process(delta):
	if faceRight:
		self.position.x += speed * delta
	else:
		self.position.x -= speed * delta		


func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()
