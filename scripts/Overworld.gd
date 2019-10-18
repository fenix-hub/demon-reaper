extends Node2D

onready var Player = preload("res://scenes/player.tscn")
onready var Humans = preload("res://scenes/human.tscn")
onready var YSort = $YSort
onready var Incrementer = preload("res://scenes/Incrementer.tscn")
var humans = 30
var player 
var menu = false
onready var Canvas = $CanvasLayer
var some_ui_open = false
# Called when the node enters the scene tree for the first time.
func _ready():
	
	
	randomize()
	var incr = randi()%2
	audio_player.music_stream(audio_player.overworld)
	audio_player.music_play()
	
	elements_handler.incrementer = incr
	
	load_player()
	generate_humans()
	elements_handler.luogo = scene_loader.Overworld
	elements_handler._save()
	
	if elements_handler.stage>0:
		var incrementer = Incrementer.instance()
		Canvas.add_child(incrementer)

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
			
			human.position.x = rand_range(-600,+600) + (1920/2)
			human.position.y = rand_range(-350,+350) + (1080/2)
			
			YSort.add_child(human)
			human.init_random()
			elements_handler.human_list.append([human.name,human.soul_fragments,human.protectors])
	else:
		for human_t in elements_handler.human_list:
			var human = Humans.instance()
			human.position.x = rand_range(-900,+900) + (1920/2)
			human.position.y = rand_range(-400,+400) + (1080/2)
			YSort.add_child(human)
			human.init(human_t[2],human_t[1])
			if elements_handler.stage>0:
				human.soul_fragments*elements_handler.stage
			

func load_player():
	player = Player.instance()
	player.position = Vector2(1920/2,50)
	YSort.add_child(player)
	player.life.visible=false
	
	$CanvasLayer/stats.update_values()


func _on_to_underworld_area_entered(area):
	if area.name == "area_player":
		scene_loader.load_scene(scene_loader.Underworld)
		
		


