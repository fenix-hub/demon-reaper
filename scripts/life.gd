extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var life_slot = preload("res://scenes/life_slot.tscn")
# Called when the node enters the scene tree for the first time.
var slots = []
# 1 empty 0 full

func _ready():
	$Sprite.visible=false
	pass

func load_life(HP,HP_MAX):
	for i in range(0,HP_MAX):
		var life_temp = life_slot.instance()
		add_child(life_temp)
		slots.append(life_temp)
		life_temp.position.x = 13*(i+1)+(11*i)
	for i in range(0,HP):
		slots[i].frame=0
		


func svuota(HP,damage):
	for i in range(0,damage):
		if slots[HP+damage-i-1].frame==0:
			slots[HP+damage-i-1].svuota()

	# gli slot sono 0 1 2 3 4
	#				1 2 3 4 5
	# svuota HP => svuota slot di indice HP (se passo a 4 HP svuoterà lo slot 4 che sarebbe il 5 HP)