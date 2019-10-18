extends Timer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	wait_time = randf() + 1.6

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
