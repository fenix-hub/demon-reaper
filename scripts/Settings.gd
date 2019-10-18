extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var vfx = $"settings2/ Video /settings/elements2/vfx"
onready var bus = "res://default_bus_layout.tres"
# Called when the node enters the scene tree for the first time.
func _ready():
	_update_ui()
	set_levels()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func set_levels():
	$"settings2/ Audio /settings/elements2/music".set_value(elements_handler.music_level)
	$"settings2/ Audio /settings/elements2/effects".set_value(elements_handler.sound_effects_level)
	$"settings2/ Audio /settings/elements2/buttons".set_value(elements_handler.buttons_level)
	$"settings2/ Audio /settings/elements2/master".set_value(elements_handler.master_level)

func _on_Label3_pressed():
	elements_handler._save_settings()
	audio_player.button_play()
	queue_free()


func _on_vfx_pressed():
	elements_handler.emitting_particles=!elements_handler.emitting_particles
	audio_player.button_play()
	if elements_handler.emitting_particles==true:
		vfx.text="Enabled"
	else:
		vfx.text="Disabled"


func _on_audio_pressed():
	audio_player.audio_player_off()
	audio_player.button_play()

		
func _update_ui():
	if elements_handler.emitting_particles==true:
		vfx.text="Enabled"
	else:
		vfx.text="Disabled"
	


func _input(event):
	if Input.is_action_pressed("menu"):
		queue_free()

func _on_settings2_tab_selected(tab):
	audio_player.button_play()
	



func _on_master_value_changed(value):
	audio_player.set_volume("Master",value)


func _on_buttons_value_changed(value):
	audio_player.set_volume("Button",value)
	audio_player.button_play()
	
	$"settings2/ Audio /settings/values/Buttons".text=str(100+value*2)


func _on_effects_value_changed(value):
	audio_player.set_volume("Effect",value)


func _on_music_value_changed(value):
	audio_player.set_volume("Music",value)
