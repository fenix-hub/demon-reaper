extends Node

const Overworld = "res://scenes/Overworld.tscn"
const Fight = "res://scenes/Fight.tscn"
const End = "res://scenes/end.tscn"
const Credits = "res://scenes/Credits.tscn"
const Underworld = "res://scenes/Underworld.tscn"
const Profiles = "res://scenes/Profiles.tscn"
const Settings = "res://scenes/Settings.tscn"
const Incrementer = "res://scenes/Incrementer.tscn"
const Game = "res://scenes/Game_Scene.tscn"
const Controls = "res://scenes/Controls.tscn"



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func load_scene(path):
	var loader = ResourceLoader.load_interactive(path)
	Transition.play_transition(path)
	while not loader.poll():
		print(str(loader.get_stage()))
		Transition.get_node("Viewport/AnimationPlayer").stop(false)
	print("scene ''"+loader.get_resource().get_path()+"'' loaded")
	Transition.get_node("Viewport/AnimationPlayer").play()
	return loader.get_resource()
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
