extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var credits = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("credits")


func _on_RichTextLabel2_pressed():
	if credits==true:
		audio_player.button_play()
		queue_free()


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name=="credits":
		credits=true

func _input(event):
	if Input.is_action_pressed("menu"):
		queue_free()