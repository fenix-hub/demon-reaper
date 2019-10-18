extends Node

const center = Vector2(0,0)
const left = Vector2(-1,0)
const right = Vector2(1,0)
const up = Vector2(0,-1)
const down = Vector2(0,1)
const rd = Vector2(1,1)
const rt = Vector2(1,-1)
const ld = Vector2(-1,1)
const lt = Vector2(-1,-1)
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	
func rand():
	var d = randi() % 13 + 1
	match d:
		1:
			return left
		2: 
			return right
		3:
			return up
		4:
			return down
		5:
			return rd
		6:
			return rt
		7:
			return ld
		8:
			return lt
		9:
			return center
		10:
			return center
		11:
			return center
		12:
			return center
		13:
			return center