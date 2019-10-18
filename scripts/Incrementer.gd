extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	_incrementer(elements_handler.incrementer)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _incrementer(value):
	if value==0:
		$Label.text="Guardians POWER raised up"
	if value==1:
		$Label.text="Guardians SPEED raised up"
	$AnimationPlayer.play("enable")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name=="enable":
		queue_free()
