extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var current = $box/current
onready var next = $box/next
onready var price = $box/price
onready var fragments = $fragments
# Called when the node enters the scene tree for the first time.
func _ready():
	load_visual()
	get_tree().paused=true

func _input(event):
	if Input.is_action_just_pressed("menu"):
		get_parent().get_parent().get_parent().get_parent().some_ui_open=false #potevo farlo anche da elements_handler
		get_tree().paused=false
		queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func load_visual():
	current.get_node("possession_time").text = str(elements_handler.wait_time)
	current.get_node("max_guardians").text = str(elements_handler.max_guardians)
	
	next.get_node("possession_time").text = str(elements_handler.wait_time + 10)
	next.get_node("max_guardians").text = str(elements_handler.max_guardians + 1)
	
	price.get_node("possession_time").text = str((elements_handler.wait_time)*0.1)
	price.get_node("max_guardians").text = str((elements_handler.max_guardians)*2)
	
	fragments.text = "Humans possessed: "+str(elements_handler.humans_possessed)

func _on_power_pressed():
	if (elements_handler.power)*420<=elements_handler.player_soul_fragments:
		
		if elements_handler.audio==true:
			audio_player.button_play()
		elements_handler.player_soul_fragments-=(elements_handler.power)*420
		elements_handler.power+=1
		
		load_visual()
		get_tree().get_nodes_in_group("player")[0].load_elements_handler()
		elements_handler._save()

func _on_speed_pressed():
	if (elements_handler.speed)*20<=elements_handler.player_soul_fragments:
		if elements_handler.audio==true:
			audio_player.button_play()
		elements_handler.player_soul_fragments-=(elements_handler.speed)*20
		elements_handler.speed+=20
		
		load_visual()
		get_tree().get_nodes_in_group("player")[0].load_elements_handler()
		elements_handler._save()

func _on_stamina_pressed():
	if (elements_handler.stamina)*95<=elements_handler.player_soul_fragments:
		if elements_handler.audio==true:
			audio_player.button_play()
		elements_handler.player_soul_fragments-=(elements_handler.stamina)*95
		elements_handler.stamina+=1
		
		load_visual()
		get_tree().get_nodes_in_group("player")[0].load_elements_handler()
		elements_handler._save()

func _on_possession_time_pressed():
	if (elements_handler.wait_time)*0.1<=elements_handler.humans_possessed:
		if elements_handler.audio==true:
			audio_player.button_play()
		elements_handler.humans_possessed-=(elements_handler.wait_time)*0.2
		elements_handler.wait_time+=10
		
		load_visual()
		get_tree().get_nodes_in_group("player")[0].load_elements_handler()
		elements_handler._save()
	print("pressed")


func _on_max_guardians_pressed():
	if ((elements_handler.max_guardians)*2)<=elements_handler.humans_possessed:
		if elements_handler.audio==true:
			audio_player.button_play()
		elements_handler.humans_possessed-=((elements_handler.max_guardians)*2)
		elements_handler.max_guardians+=1
		
		load_visual()
		get_tree().get_nodes_in_group("player")[0].load_elements_handler()
		elements_handler._save()


func _on_Button_pressed():
	audio_player.button_play()
	get_tree().paused=false
	get_parent().get_parent().get_parent().get_parent().some_ui_open=false #potevo farlo anche da elements_handler
	queue_free()
