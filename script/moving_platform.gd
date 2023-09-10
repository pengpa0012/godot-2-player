extends StaticBody2D

@export var MOVE_OFFSET = 100
@export var SPEED = 40

var initialPos = 0
var movingRight = true

func _ready():
	initialPos = self.position.x

func _process(delta):
	if movingRight:
		self.position.x += SPEED * delta
		if self.position.x > initialPos + MOVE_OFFSET:
			movingRight = false
	else:
		self.position.x -= SPEED * delta
		if self.position.x < initialPos - MOVE_OFFSET:
			movingRight = true
