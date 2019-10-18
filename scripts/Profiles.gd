extends Control

onready var profile1 = $profiles/profile1
onready var profile2 = $profiles/profile2
onready var profile3 = $profiles/profile3

var save

var slot1 = false
var slot2 = false
var slot3 = false
# Called when the node enters the scene tree for the first time.
func _ready():
	
	load_slots()


func load_slots():
	if elements_handler.temp_save1==false:
		profile1.get_node("elements/container/profile_icon").modulate = Color(68,68,68,255)
	else:
		slot1=true
		save = elements_handler.save1
		elements_handler.save = save
		elements_handler._load()
		profile1.get_node("elements/slot").text = str(elements_handler.luogo_nome)
		
	if elements_handler.temp_save2==false:
		profile2.get_node("elements/container/profile_icon").modulate = Color(68,68,68,255)
	else:
		slot2=true
		save = elements_handler.save2
		elements_handler.save = save
		elements_handler._load()
		profile2.get_node("elements/slot").text = str(elements_handler.luogo_nome)
		
	if elements_handler.temp_save3==false:
		profile3.get_node("elements/container/profile_icon").modulate = Color(68,68,68,255)
	else:
		slot3=true
		save = elements_handler.save3
		elements_handler.save = save
		elements_handler._load()
		profile3.get_node("elements/slot").text = str(elements_handler.luogo_nome)

func _on_Label3_pressed():
	audio_player.button_play()
	queue_free()
	

func _on_profile1_pressed():
	audio_player.button_play()
	if slot1 == false:
		save = elements_handler.save1
		elements_handler.save = save
		get_tree().change_scene(scene_loader.Underworld)
	else:
		save = elements_handler.save1
		elements_handler.save = save
		elements_handler._load()
		scene_loader.load_scene(scene_loader.elements_handler.luogo)


func _on_profile2_pressed():
	audio_player.button_play()
	if slot2 == false:
		save = elements_handler.save2
		elements_handler.save = save
		get_tree().change_scene(scene_loader.Underworld)
	else:
		save = elements_handler.save2
		elements_handler.save = save
		elements_handler._load()
		scene_loader.load_scene(scene_loader.elements_handler.luogo)


func _on_profile3_pressed():
	audio_player.button_play()
	if slot3 == false:
		save = elements_handler.save3
		elements_handler.save = save
		get_tree().change_scene(scene_loader.Underworld)
	else:
		save = elements_handler.save3
		elements_handler.save = save
		elements_handler._load()
		scene_loader.load_scene(scene_loader.elements_handler.luogo)


func _input(event):
	if Input.is_action_pressed("menu"):
		queue_free()
