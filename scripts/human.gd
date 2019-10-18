extends KinematicBody2D

export (int) var move_speed = 50


var move_direction = dir.center
var sprite_direction = "_Down"
var motion

var soul_fragments = 0
onready var souls_number = $souls
onready var protector = preload("res://scenes/protector.tscn")
onready var Fight = preload("res://scenes/Fight.tscn")
var protector_list = []

var protectors
var wandering
var alive = true
var first = true

func _ready():
	randomize()
	move_speed+= rand_range(-20,+20)
	souls_number.visible=false

func init_random():
	$wander.start()
	random_protectors()
	random_souls()


func init(p,s):
	$wander.start()
	init_protectors(p)
	init_souls(s)

func random_protectors():
	protectors = randi() % 4 + 1
	for i in range(0,protectors):
		var prot = protector.instance()
		get_node("YSort/pos"+str(i+1)).add_child(prot)
#		prot.add_to_group("protectors_world")
		protector_list.append(prot)
		prot.visible=false

func init_protectors(p):
		protectors = p
		for i in range(0,p):
			var prot = protector.instance()
			get_node("YSort/pos"+str(i+1)).add_child(prot)
#			prot.add_to_group("protectors_world")
			protector_list.append(prot)
			prot.visible=false

func init_souls(s):
	soul_fragments = s
	souls_number.text=str(soul_fragments)

func random_souls():
	soul_fragments = randi() % 120+20
	souls_number.text=str(soul_fragments)

func _physics_process(delta):
		if move_direction != dir.center:
			animation_play("Idle")
		else:
			animation_play("Idle")
			
		move_loop()
		sprite_loop2()
		




func move_loop():
		
		motion = move_direction.normalized() * move_speed
		
#warning-ignore:return_value_discarded
#warning-ignore:return_value_discarded
#warning-ignore:return_value_discarded
		move_and_slide(motion,dir.center)


func sprite_loop2():
	if wandering == dir.rd:
	 	  sprite_direction ="_RightDown"
	elif wandering == dir.down:
		sprite_direction ="_Down"
	elif wandering == dir.ld:
		sprite_direction ="_LeftDown"
	elif wandering == dir.left:
		sprite_direction ="_Left"
	elif wandering == dir.lt:
		sprite_direction ="_LeftTop"
	elif wandering == dir.up:
		sprite_direction ="_Up"
	elif wandering == dir.rt:
		sprite_direction ="_RightTop"
	elif wandering == dir.right:
		sprite_direction ="_Right"

func animation_play(animation):# to atcive animation_switch
	var New_anim = str(animation,sprite_direction)
	if $anim.current_animation != New_anim:
		$anim.play(New_anim)


func _on_wander_timeout():
	wandering = dir.rand()
	move_direction = wandering
	

func _on_effect_animation_finished(anim_name):
	if anim_name == "death":
		queue_free()


func _on_area_human_area_entered(area):
	if area.name=="reveal":
		souls_number.visible=true
		for prot in protector_list:
			prot.visible=true


func _on_area_human_area_exited(area):
	if area.name=="reveal":
		souls_number.visible=false
		for prot in protector_list:
			prot.visible=false
