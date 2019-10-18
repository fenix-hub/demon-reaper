extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var power
var HP
var HP_MAX
var stamina
var speed

var humanity_fragments
var guardians_possessed
var humans_possessed

onready var values = $ColorRect/vars/values
onready var stats = $ColorRect/vars/stats

var data = {}
# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	update_values()
	

func update_values():
	power = elements_handler.power
	HP = elements_handler.HP
	HP_MAX = elements_handler.HP_MAX
	stamina = elements_handler.stamina
	speed = elements_handler.speed
	
	humanity_fragments = elements_handler.player_soul_fragments
	humans_possessed = elements_handler.humans_possessed
	guardians_possessed = elements_handler.guardians_possessed
	
	values.get_node("guardians").text = str(guardians_possessed)
	values.get_node("humans_possessed").text = str(humans_possessed)
	values.get_node("souls").text = str(humanity_fragments)
	
	stats.get_node("life").text = str(HP)+"/"+str(HP_MAX)
	stats.get_node("power").text = str(power)
	stats.get_node("stamina").text = str(stamina)
	stats.get_node("speed").text = str(speed)
	

func enable():
	visible = true
	$AnimationPlayer.play("enable")

func disable():
	$AnimationPlayer.play("disable")
	visible = false

