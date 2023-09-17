extends ProgressBar
@export var COLOR := "#00FF00"

func _ready():
	var sb = StyleBoxFlat.new()
	add_theme_stylebox_override("fill", sb)
	sb.bg_color = Color(COLOR)
