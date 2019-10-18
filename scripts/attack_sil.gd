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

func _on_attack_sil_area_entered(area):
	
	if area.name == "area_player" and entity!="PLAYER":
		var enemy = get_parent()
		area.get_parent().damage(damage,enemy)
	
	if area.name == "area_enemy" and entity=="PROTECTOR":
		area.get_parent().damage_loop(damage)
		
	if area.name == "area_protector" and entity=="ENEMY":
		area.get_parent().damage_loop(damage)