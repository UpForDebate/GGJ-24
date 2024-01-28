extends Node


var main_menu = preload("res://scenes/main_menu.tscn")

@export var characters : Array[CharacterInfo]

# Called when the node enters the scene tree for the first time.
func _ready():
	Game.charPool = characters
	Game.RoastPair.resize(2)
	
	self.add_child(main_menu.instantiate())
	


func reset():
	Game.RoastPair.clear()
	Game.RoastPair.resize(2)
	randomizeMatchup()
	Game.state = 0



func randomizeMatchup():
	Game.charMatchup.clear()
	Game.charMatchup.resize(4)
	var placement = [0, 1, 2, 3]
	for i in 4:
		var number = placement.pick_random()
		Game.charMatchup[i] = number
		placement.erase(number)

