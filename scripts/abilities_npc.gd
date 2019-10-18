extends KinematicBody2D

var move_direction = dir.center
var sprite_direction = "_Down"
var looking = 0
onready var Power_Ups = preload("res://scenes/Power_Ups.tscn")
onready var Others = preload("res://scenes/Others.tscn")
var target
onready var player 
var open = false
var area_temp

func _ready():
	randomize()
	

func _physics_process(delta):
	if Input.is_action_just_pressed("interact"):
		if area_temp=="abilities":
			$CanvasLayer.add_child(Power_Ups.instance())
			get_parent().get_parent().some_ui_open=true
		if area_temp=="others":
			$CanvasLayer.add_child(Others.instance())
			get_parent().get_parent().some_ui_open=true
		
	player = get_tree().get_nodes_in_group("player")[0]
	looking = player.position.angle_to_point(position)
	animation_play("Idle")
	sprite_loop2()

	

func sprite_loop2():

	if looking > 0.4 and looking < 1.1:
	 	  sprite_direction ="_RightDown"
	elif looking > 1.2 and looking < 1.9:
		sprite_direction ="_Down"
	elif looking > 2 and looking < 2.8:
		sprite_direction ="_LeftDown"
	elif looking < -2.65 or looking > 2.9:
		sprite_direction ="_Left"
	elif looking > -2.64 and looking < -1.8:
		sprite_direction ="_LeftTop"
	elif looking > -1.9 and looking < -1.2:
		sprite_direction ="_Up"
	elif looking > -1.3 and looking < -0.4:
		sprite_direction ="_RightTop"
	elif looking > -0.3 and looking < 0.3:
		sprite_direction ="_Right"

func animation_play(animation):# to atcive animation_switch
	var New_anim = str(animation,sprite_direction)
	if $anim.current_animation != New_anim:
		$anim.play(New_anim)

func _on_enemy_tree_entered():
	$death_particle/particle.emitting=elements_handler.emitting_particles


func _on_npc_powers_area_entered(area):
	if area.name=="area_player":
		area_temp = "others"
		
	print(area)




func _on_npc_powers_area_exited(area):
	print(area.name)
	if area.name=="area_player":
		area_temp="null"
