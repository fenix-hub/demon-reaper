extends KinematicBody2D

export (int) var move_speed = 160

var move_direction = dir.center
var sprite_direction = "_Down"
var looking = 0
var motion
var target
var attacking = false 
const MAX_ATTACK_TIME = 20
const MAX_DAMAGE_TIME = MAX_ATTACK_TIME+10
const CAN_ATTACK_TIME = 60
var attack_time = MAX_ATTACK_TIME
var damage_time = MAX_DAMAGE_TIME
var can_attack = true
var can_attack_time = 0
var n_attack = 0
var damage = false
var HP = 5
var HP_MAX = 5
var alive = true
var enemy_pos
onready var life = $UI/life
onready var soul_counter = $UI/label_s
var soul_fragments = 0
onready var melee = $attack_sil_player
var stamina = 3
onready var light = $light_reveal
var guardians_possessed
var humans_possessed


func _ready():
	add_to_group("player")
	melee.visible=false
	melee.entity = "PLAYER"
	melee.monitoring = false
	
	load_elements_handler()
	
	soul_counter.set_text("Fragments of humanity: "+str(soul_fragments))
	if elements_handler.HP != 0:
		HP = elements_handler.HP
	else:
		HP = 5
		
	
	
	
	life.load_life(HP,HP_MAX)

func _physics_process(delta):
	if visible==true:
		looking = get_global_mouse_position().angle_to_point(position)
		control_loop()
		move_loop()
		attack_loop()
		
	life_loop()
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

func attack_loop():
	if Input.is_action_just_pressed("melee") and can_attack == true and attacking == false:
		attacking = true
		target = looking
		n_attack+=1
		melee.visible = true
		melee.rotation_degrees = looking*180/PI
		melee.monitoring = true
		melee.attack()
		if n_attack == stamina:
			can_attack = false
			
	if Input.is_action_just_pressed("see_protectors"):
		print("save")
		elements_handler._save()
	
	if can_attack == false:
		if can_attack_time < CAN_ATTACK_TIME:
			can_attack_time+=1
		else:
			can_attack_time = 0
			can_attack = true
			n_attack = 0

func control_loop():#control key
	var RIGHT = Input.is_action_pressed("ui_right")
	var LEFT = Input.is_action_pressed("ui_left")
	var DOWN = Input.is_action_pressed("ui_down")
	var UP = Input.is_action_pressed("ui_up")
	move_direction.x = int(RIGHT) - int(LEFT)
	move_direction.y = int(DOWN)  - int(UP)

func move_loop():
	if attacking == false and damage == false:
		motion = move_direction.normalized() * move_speed
		move_and_slide(motion, dir.center)
	else:
		motion = Vector2(cos(looking),sin(looking)).normalized()*move_speed/2*attack_time/10
		move_and_slide(motion,dir.center)
		if attack_time>0:
			attack_time-=1
	
	if damage == true:
		move_and_slide(Vector2(cos(position.angle_to_point(enemy_pos)),sin(position.angle_to_point(enemy_pos))).normalized()*move_speed*damage_time/10,dir.center)
		if damage_time>0:
			damage_time-=1

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
		

func life_loop():
	if HP <= 0 and alive:
		$effect.play("death")
		alive=!alive

func animation_play(animation):# to atcive animation_switch
	var New_anim = str(animation,sprite_direction)
	if $anim.current_animation != New_anim:
		$anim.play(New_anim)

func _on_anim_animation_finished(anim_name):
	if "Attack_" in anim_name:
		attacking = false
		attack_time = MAX_ATTACK_TIME

func damage(damage_amount,enemy):
	if damage == false : 
		$effect.play("damage")
		enemy_pos = enemy.position
		damage = true
		HP-=damage_amount
		elements_handler.HP = HP
		life.svuota(HP,damage_amount)


func _on_effect_animation_finished(anim_name):
	if anim_name == "death":
		visible = false
		$player_hit.disabled
		$area_player/CollisionShape2D.disabled=true
	
	
	
	if anim_name == "damage":
		damage = false
		damage_time = MAX_DAMAGE_TIME

func _on_player_tree_exited():
	remove_from_group("player")

func load_elements_handler():
#	elements_handler.set_HP(HP)
#	elements_handler.set_HP_MAX(HP_MAX)
#	elements_handler.set_power($attack_sil_player.damage)
#	elements_handler.set_speed(move_speed)
#	elements_handler.set_stamina(stamina)
	HP=elements_handler.HP
	HP_MAX=elements_handler.HP_MAX
	melee.damage=elements_handler.power
	move_speed=elements_handler.speed
	stamina=elements_handler.stamina
	soul_fragments = elements_handler.player_soul_fragments
	guardians_possessed = elements_handler.guardians_possessed
	humans_possessed = elements_handler.humans_possessed
	

func _on_player_tree_entered():
	$player_particles/particle.emitting=elements_handler.emitting_particles
