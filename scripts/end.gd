extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var next_pass
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("menu")

func time_finished():
	$title.text=str("THE TIME HAS COME")
	$descr.text=str("And the poor soul you occupied was finally freed...")
	$retry.text="Go Back"
	next_pass = 1
	

func death():
	$title.text=str("YOU VANISHED")
	$descr.text=str("And the guardians you possessed were lost forever...")
	$retry.text="Rebirth"
	next_pass = 2

func _on_TextureButton_pressed():
	get_tree().quit()


func _on_retry_pressed():
	if next_pass == 1:
		get_tree().change_scene(scene_loader.Overworld)
		get_tree().paused = false
	elif next_pass == 2:
		get_tree().change_scene(scene_loader.Underworld)
