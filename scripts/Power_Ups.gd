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

func load_visual():
	current.get_node("power").text = str(elements_handler.power)
	current.get_node("speed").text = str(elements_handler.speed)
	current.get_node("stamina").text = str(elements_handler.stamina)
	current.get_node("hp").text = str(elements_handler.HP_MAX)
	
	next.get_node("power").text = str(elements_handler.power + 1)
	next.get_node("speed").text = str(elements_handler.speed + 20)
	next.get_node("stamina").text = str(elements_handler.stamina + 1)
	next.get_node("hp").text = str(elements_handler.HP_MAX + 1)
	
	price.get_node("power").text = str((elements_handler.power)*320)
	price.get_node("speed").text = str((elements_handler.speed)*4)
	price.get_node("stamina").text = str((elements_handler.stamina)*95)
	price.get_node("hp").text = str((elements_handler.HP_MAX)*115)
	
	fragments.text = "Humanity fragments: "+str(elements_handler.player_soul_fragments)

func _on_power_pressed():
	if (elements_handler.power)*420<=elements_handler.player_soul_fragments:
		if elements_handler.audio==true:
			audio_player.button_play()
		elements_handler.player_soul_fragments-=(elements_handler.power)*320
		elements_handler.power+=1
		
		load_visual()
		get_tree().get_nodes_in_group("player")[0].load_elements_handler()
		elements_handler._save()

func _on_speed_pressed():
	if (elements_handler.speed)*4<=elements_handler.player_soul_fragments:
		if elements_handler.audio==true:
			audio_player.button_play()
		elements_handler.player_soul_fragments-=(elements_handler.speed)*4
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

func _on_hp_pressed():
	if (elements_handler.HP_MAX)*115<=elements_handler.player_soul_fragments:
		if elements_handler.audio==true:
			audio_player.button_play()
		elements_handler.player_soul_fragments-=(elements_handler.stamina)*115
		elements_handler.HP_MAX+=1
		
		elements_handler.HP=elements_handler.HP_MAX
		load_visual()
		get_tree().get_nodes_in_group("player")[0].load_elements_handler()
		elements_handler._save()


func _on_back_pressed():
	audio_player.button_play()
	get_tree().paused=false
	get_parent().get_parent().get_parent().get_parent().some_ui_open=false #potevo farlo anche da elements_handler
	queue_free()
