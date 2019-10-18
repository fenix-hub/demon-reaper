extends Sprite

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	frame = 1
	pass # Replace with function body.

func svuota():
	$anim.play("svuota")