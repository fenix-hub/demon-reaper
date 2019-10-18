extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var menu = false
# Called when the node enters the scene tree for the first time.

func _ready():
	visible=false
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _input(event):
	if Input.is_action_just_pressed("menu") and get_parent().get_parent().some_ui_open==false:
		if menu==false:
			menu=true
			enable()
		else:
			menu=false
			disable()

func _on_exit_pressed():
	audio_player.button_play()
	get_tree().quit()
	
func enable():
	$AnimationPlayer.play("enable")
	get_tree().paused = true
	
func disable():
	$AnimationPlayer.play("disable")
	get_tree().paused = false



func _on_Overworld_menu(boolean):
	if boolean==true:
		enable()
	else:
		disable()


func _on_settings_pressed():
	audio_player.button_play()
	add_child(scene_loader.load_scene(scene_loader.Settings).instance())
