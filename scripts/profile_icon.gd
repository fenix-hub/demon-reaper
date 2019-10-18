extends Sprite

var sprite_direction

func _ready():
	sprite_direction ="_Down"
	animation_play("Idle")
	

func animation_play(animation):# to atcive animation_switch
	var New_anim = str(animation,sprite_direction)
	if $anim.current_animation != New_anim:
		$anim.play(New_anim)

func _on_player_tree_entered():
	$player_particles/particle.emitting=elements_handler.emitting_particles

