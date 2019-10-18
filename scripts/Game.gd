extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	emitting_particles(elements_handler.emitting_particles)
	
func emitting_particles(e):
	var particles = get_tree().get_nodes_in_group("particles")
	for node in particles:
		node.get_node("particle").emitting=e

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Game_tree_entered():
	pass # Replace with function body.
