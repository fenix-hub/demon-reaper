extends Sprite

var sprite_direction = "_Down"
var wandering = Vector2()

func _ready():
	$wander.start()
	

func _physics_process(delta):
		
		sprite_loop()
		animation_play("Idle")
		
		

func sprite_loop():
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
