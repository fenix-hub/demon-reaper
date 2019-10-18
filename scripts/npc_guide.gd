extends KinematicBody2D

var move_direction = dir.center
var sprite_direction = "_Down"
var looking = 0
onready var Guide = preload("res://scenes/Guide.tscn")
var target
onready var player 
var open = false
var area_temp

func _ready():
	randomize()
	

func _physics_process(delta):
	if Input.is_action_just_pressed("interact"):
		if area_temp=="guide":
			$CanvasLayer.add_child(Guide.instance())
			get_parent().get_parent().some_ui_open=true
			print("GUIDA")
		
	player = get_tree().get_nodes_in_group("player")[0]
	looking = player.position.angle_to_point(position)
	$sprite/eye1.rotation_degrees = looking*180/PI
	$sprite/eye2.rotation_degrees = looking*180/PI
	$AnimationPlayer.play("Idle")


func _on_enemy_tree_entered():
	$death_particle/particle.emitting=elements_handler.emitting_particles



func _on_npc_guide_area_entered(area):
	if area.name=="area_player":
		area_temp = "guide"
		$HBoxContainer.visible=true


func _on_npc_guide_area_exited(area):
	if area.name=="area_player":
		area_temp = "null"
	$HBoxContainer.visible=false
