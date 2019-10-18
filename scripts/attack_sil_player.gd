extends Area2D

# Declare member variables here. Examples:
# var a = 2
var entity = null
var damage = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	if $"../sprite".flip_h == true:
		scale = Vector2(1,-1)
	

func attack():
	$AnimationPlayer.play("melee")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "melee":
		visible = false
		monitoring = false

func _on_attack_sil_player_area_entered(area):
	if area.name == "area_enemy":
		area.get_parent().damage_loop(damage)
		
	
	if area.name == "area_human":
		var human = area.get_parent()
		elements_handler.protectors=human.protectors
		print("Now protectors: "+str(elements_handler.protectors))
		elements_handler.soul_fragments=human.soul_fragments
		for i in elements_handler.human_list.size()-1:
			print(elements_handler.human_list[i][0])
			if elements_handler.human_list[i][0] == human.name:
				elements_handler.human_list.remove(i)
		human.queue_free()
		
		get_tree().change_scene(scene_loader.Fight)
		
		
		
