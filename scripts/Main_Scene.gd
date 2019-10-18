extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var titlescreen=false
# Called when the node enters the scene tree for the first time.




func _ready():
	elements_handler._load_settings()
	audio_player.music_stream(audio_player.titlescreen)
	audio_player.music_play()
	
	$AnimationPlayer.play("titlescreen")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name=="titlescreen":
		titlescreen=true

#func _on_new_game_mouse_entered():
#	if titlescreen==true:
#		$AnimationPlayer.play("new_game")
#
#func _on_new_game_mouse_exited():
#	if titlescreen==true:
#		$AnimationPlayer.play("new_game_idle")
#
#func _on_settings_mouse_entered():
#	if titlescreen==true:
#		$AnimationPlayer3.play("settings")
#
#
#func _on_settings_mouse_exited():
#	if titlescreen==true:
#		$AnimationPlayer3.play("settings_idle")
#
#
#func _on_exit_mouse_entered():
#	if titlescreen==true:
#		$AnimationPlayer4.play("exit")
#
#
#func _on_exit_mouse_exited():
#	if titlescreen==true:
#		$AnimationPlayer4.play("exit_idle")
#
#
#func _on_credits_mouse_entered():
#	if titlescreen==true:
#		$AnimationPlayer5.play("credits")
#
#
#func _on_credits_mouse_exited():
#	if titlescreen==true:
#		$AnimationPlayer5.play("credits_idle")

func _on_exit_pressed():
	if titlescreen==true:
		audio_player.button_play()
		get_tree().quit()


func _on_credits_pressed():
	if titlescreen==true:
		audio_player.button_play()
		add_child(load(scene_loader.Credits).instance())
		


func _on_new_game_pressed():
	if titlescreen==true:
		audio_player.button_play()
		add_child(load(scene_loader.Profiles).instance())
		


func _on_settings_pressed():
	if titlescreen==true:
		audio_player.button_play()
		add_child(load(scene_loader.Settings).instance())
		


func _on_controls_pressed():
	if titlescreen==true:
		audio_player.button_play()
		add_child(load(scene_loader.Controls).instance())
