extends Node2D


var Timer 
onready var time = $CanvasLayer/Time
onready var Enemy = preload("res://scenes/enemy.tscn")
onready var Player = preload("res://scenes/player.tscn")
onready var Protector = preload("res://scenes/protector_player.tscn")
var enemies = 0
var spawn = Vector2()
var temp_player = null
var ending = false
var timeout = false
var some_ui_open = false

func _ready():
	elements_handler.enemies_on_stage=0
	randomize()
	audio_player.music_stream(audio_player.fight)
	audio_player.music_play()
	
	temp_player = Player.instance()
	temp_player.position = Vector2(1920/2,1080/2)
	$YSort.add_child(temp_player)
	temp_player.get_node("light_reveal").visible=false
	$platform.play("color")
	
	for i in range(0,elements_handler.guardians_possessed):
		var protector = Protector.instance()
		$YSort.add_child(protector)
		if spawn==Vector2(0,0):
			spawn.x=temp_player.position.x + rand_range(-80,80)
			spawn.y=temp_player.position.y + rand_range(-80,80)
		protector.position = Vector2(spawn.x,spawn.y)
		spawn = Vector2()
	
	enemies = elements_handler.protectors
	for i in range(0,enemies):
		var enemy = Enemy.instance()
		$YSort.add_child(enemy)
		if spawn==Vector2(0,0):
			var norm = randi()%2
			if norm == 0:
				spawn.x=temp_player.position.x + rand_range(-250,-90)
				spawn.y=temp_player.position.y + rand_range(-120,-90)
			else:
				spawn.x=temp_player.position.x + rand_range(90,250)
				spawn.y=temp_player.position.y + rand_range(90,120)
		enemy.position = Vector2(spawn.x,spawn.y)
		random_incrementer(elements_handler.incrementer,enemy)
		spawn = Vector2()
		elements_handler.enemies_on_stage+=1
		
	
	
	
	Timer = $Timer
	Timer.wait_time = elements_handler.wait_time
	Timer.start()
	print("ENEMIES: "+str(enemies))
	print("ENEMIES ON STAGE: "+str(elements_handler.enemies_on_stage))

func _physics_process(delta):
	time.set_text(str(round(Timer.time_left)))
	
	if temp_player.visible==false and ending == false and timeout == false:
		ending = true
		var end = scene_loader.load_scene(scene_loader.End).instance()
		elements_handler.HP=elements_handler.HP_MAX
		elements_handler.player_soul_fragments=0
		elements_handler.guardians_possessed=0
		elements_handler.humans_possessed=0
		elements_handler.stage=0
		end.death()
		$Timer.stop()
		$CanvasLayer.add_child(end)
		
	if elements_handler.enemies_on_stage==0 and timeout == false and ending == false:
		elements_handler.player_soul_fragments+=elements_handler.soul_fragments
		temp_player.HP = elements_handler.HP
		temp_player.position = Vector2(1920/2,1080/2)
		temp_player.soul_fragments = elements_handler.player_soul_fragments
		for i in range(0,enemies):
			if i < elements_handler.max_guardians and elements_handler.guardians_possessed<elements_handler.max_guardians:
				elements_handler.guardians_possessed+=1
		elements_handler.luogo = scene_loader.Overworld
		elements_handler.humans_possessed+=1
		elements_handler.stage+=1
		elements_handler._save()
		get_tree().change_scene(scene_loader.Overworld)
		



func _on_Timer_timeout():
	if ending == false and timeout == false:
		if temp_player.HP>0:
			timeout = true
			var end = scene_loader.load_scene(scene_loader.End).instance()
			end.time_finished()
			elements_handler.luogo = scene_loader.Overworld
			elements_handler.stage+=1
			elements_handler._save()
			$CanvasLayer.add_child(end)
			get_tree().paused = true
		else:
			ending = true
			var end = scene_loader.load_scene(scene_loader.End).instance()
			elements_handler.HP=elements_handler.HP_MAX
			elements_handler.player_soul_fragments=0
			elements_handler.guardians_possessed=0
			elements_handler.humans_possessed=0
			elements_handler.stage=0
			end.death()
			$Timer.stop()
			$CanvasLayer.add_child(end)

func random_incrementer(incr,enemy):
	match (incr):
		0: #attacco
			enemy.weapon.damage+=elements_handler.stage
		1: #velocita
			enemy.move_speed+=elements_handler.stage*20