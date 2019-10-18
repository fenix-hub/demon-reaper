extends KinematicBody2D

export (int) var move_speed = 50
export (int) var speed_factor 

var move_direction = dir.center
var sprite_direction = "_Down"
var looking = 0
var motion
var target
var attacking = false 
const MAX_ATTACK_TIME = 20
const CAN_ATTACK_TIME = 60
const MAX_DAMAGE_TIME = MAX_ATTACK_TIME+5
var damage_time = MAX_ATTACK_TIME
var attack_time = MAX_ATTACK_TIME
var can_attack = true
onready var player 
var damage = false
var HP = 10
var wandering
var alive = true
onready var weapon = $attack_sil
var wait = 20

func _ready():
	randomize()
	add_to_group("protectors")
	weapon.visible = false
	weapon.monitoring = false
	weapon.entity = "PROTECTOR"
	speed_factor = rand_range(-20,20)
	move_speed+=speed_factor

func _physics_process(delta):
	if elements_handler.enemies_on_stage>0:
		player = get_tree().get_nodes_in_group("enemies")[0]
		life_loop()
		
		looking = player.position.angle_to_point(position)
		$wander.start()
		sprite_loop2()
		attack_loop()
		sprite_loop()
		if alive and wait<=0:
			move_loop()
			control_loop()
		else:
			wait-=1
	else:
		sprite_loop2()
		
		
		
		
		
	if move_direction != dir.center:
		if attacking == false:
			animation_play("Idle")
		else:
			animation_play("Attack")
	else:
		if attacking == false:
			animation_play("Idle")
		else:
			animation_play("Attack")

func control_loop():#control key
	if player.visible == true:
		move_direction.x = cos(looking)
		move_direction.y = sin(looking)

func move_loop():
	if damage == false:
		motion = move_direction.normalized() * move_speed
		move_and_slide(motion,dir.center)
	else:
		move_and_slide(-move_direction.normalized()*move_speed*3,dir.center)

func attack_loop():
	if can_attack == true and attacking == false and abs(position.x-player.position.x)<30 and abs(position.y-player.position.y)<30 and damage==false:
		attacking = true
		target = looking
		weapon.rotation_degrees = looking*180/PI
		weapon.visible = true
		weapon.monitoring = true
		weapon.attack()

func damage_loop(damage_amount):
	if damage == false:
		damage = true
		effect_play("damage")
		HP-=damage_amount
		print("HIT_ENEMY")
	

func life_loop():
	if HP <= 0 and alive:
		alive=!alive
		print("LIFE: "+str(HP))
		effect_play("DEATH")


func sprite_loop2():
	if attacking == false:
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

func sprite_loop():
	if attacking == false:
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

func effect_play(animation):# to atcive animation_switch
	var New_anim = str(animation)
	if $effect.current_animation != New_anim:
		$effect.play(New_anim)

func _on_anim_animation_finished(anim_name):
	if "Attack_" in anim_name:
		attacking = false
		attack_time = MAX_ATTACK_TIME

func _on_wander_timeout():
	wandering = dir.rand()
	looking = wandering.angle()
	move_direction = wandering

func _on_effect_animation_finished(anim_name):
	if anim_name == "DEATH":
		print("ding")
		elements_handler.guardians_possessed-=1
		queue_free()
	if anim_name == "damage":
		damage = false


func _on_enemy_tree_entered():
	$death_particle/particle.emitting=elements_handler.emitting_particles
