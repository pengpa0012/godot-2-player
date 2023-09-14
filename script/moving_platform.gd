extends CharacterBody2D

@export var MOVE_OFFSET = 100
@export var movingRight = true
@export var movingUp = true
@export var SPEED = 40
@export var HORIZONTAL = true

var initialPos = 0

func _ready():
	initialPos = self.position.x

func _process(delta):
	if HORIZONTAL:
		if movingRight:
			self.position.x += SPEED * delta
			if self.position.x > initialPos + MOVE_OFFSET:
				movingRight = false
		else:
			self.position.x -= SPEED * delta
			if self.position.x < initialPos - MOVE_OFFSET:
				movingRight = true
				
	else:
		if movingUp:
			self.position.y -= SPEED * delta
			if self.position.y > initialPos - MOVE_OFFSET:
				movingUp = false
		else:
			self.position.y += SPEED * delta
			if self.position.y < initialPos + MOVE_OFFSET:
				movingUp = true
