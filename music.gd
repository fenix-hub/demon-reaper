extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var music = $music
onready var button = $button
onready var effect1 = $effect1
onready var effect2 = $effect2

var titlescreen = preload("res://music/soundtrack1.wav")
var overworld = preload("res://music/retro_lofi.wav")
var underworld = preload("res://music/Galaxy.wav")
var fight = preload("res://music/CothicTHEME.wav")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func music_stream(path):
	music.set_stream(path)

func button_stream(path):
	button.set_stream(path)

func effect1_stream(path):
	effect1.set_stream(path)

func effect2_stream(path):
	effect2.set_stream(path)

func music_play():
	if elements_handler.audio==true:
		music.play()
		music.get_stream().set_loop_mode(0)
		music.get_stream().set_loop_begin(music.get_stream().get_length())



func audio_player_off():
	elements_handler.audio=!elements_handler.audio
	print(elements_handler.audio)
	if elements_handler.audio==false:
			for player in get_children():
				player.stop()
	else:
		music_play()
	

func button_play():
	if elements_handler.audio==true:
		button.play()
	

func effect1_play():
	if elements_handler.audio==true:
		effect1.play()
	

func effect2_play():
	if elements_handler.audio==true:
		effect2.play()

func set_volume(bus,vol):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(bus), vol)
	match (bus):
		"Master":
			elements_handler.master_level = vol
		"Button":
			elements_handler.buttons_level = vol
		"Effect":
			elements_handler.sound_effects_level = vol
		"Music":
			elements_handler.music_level = vol
			

