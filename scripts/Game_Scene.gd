extends Node2D


func _ready():
	if elements_handler.location!=null:
		add_child(elements_handler.location.instance())
	else:
		add_child(scene_loader.Underworld)
	pass # Replace with function body.


