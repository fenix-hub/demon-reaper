extends Node2D

onready var Player = preload("res://scenes/player.tscn")
onready var Humans = preload("res://scenes/human.tscn")
onready var Npc_Abilities = preload("res://scenes/npc_abilities.tscn")
onready var YSort = $YSort
var some_ui_open = false
var humans = 30
var player 
var menu=false

# Called when the node enters the scene tree for the first time.
func _ready():
	load_player()
	audio_player.music_stream(audio_player.underworld)
	audio_player.music_play()
	elements_handler.luogo = scene_loader.Underworld
	elements_handler._save()
	elements_handler.human_list.clear()
	
	#generate_humans()

func _process(delta):
	if Input.is_action_just_pressed("stats"):
			$CanvasLayer/stats.enable()
	if Input.is_action_just_released("stats"):
			$CanvasLayer/stats.disable()
			
		
	
	
	
#		var visible
#		for prot in get_tree().get_nodes_in_group("protectors_world"):
#			prot.visible=!prot.visible
#			visible = prot.visible
#		if !visible:
#			get_tree().get_nodes_in_group("player")[0].modulate=Color(1,1,1,0.6)
#		else:
#			get_tree().get_nodes_in_group("player")[0].modulate=Color(1,1,1,1)

func generate_humans():
	randomize()
	if elements_handler.human_list.empty()==true:
		
		for i in range(0,humans):
			var human = Humans.instance()
			
			human.position.x = rand_range(-900,+900) + player.position.x
			human.position.y = rand_range(-400,+400) + player.position.y
			
			YSort.add_child(human)
			human.init_random()
			elements_handler.human_list.append([human.name,human.soul_fragments,human.protectors])
	else:
		for human_t in elements_handler.human_list:
			var human = Humans.instance()
			human.position.x = rand_range(-900,+900) + player.position.x
			human.position.y = rand_range(-400,+400) + player.position.y
			YSort.add_child(human)
			human.init(human_t[2],human_t[1])
			

func load_npcs():
	var npc1 = Npc_Abilities.instance()
	npc1.position = Vector2(90,1080/2)
	YSort.add_child(npc1)
	

func load_player():
	player = Player.instance()
	player.position = Vector2(1920/2,1080/2)
	YSort.add_child(player)
	player.life.visible=false
	player.light.visible=false
	
	$CanvasLayer/stats.update_values()

func _on_to_overworld_area_entered(area):
	if area.name == "area_player":
		Transition.play_transition(scene_loader.Overworld)
		reset()
		
func reset():
	elements_handler.humans_possessed=0
	elements_handler.guardians_possessed=0
	elements_handler.player_soul_fragments=0
	elements_handler.HP=elements_handler.HP_MAX
	elements_handler.stage=0
