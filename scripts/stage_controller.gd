extends Control

@export var SpawnA : Node3D
@export var SpawnB : Node3D
@export var Spotlight : Sprite3D

var newspaper = preload("res://scenes/newspaper.tscn")


@export var selected_char : Node3D = null


# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().get_node("FadeIn/AnimationPlayer").play("fade_in")
	updateFileWindow()
	set_process(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Eliminate"):
		_on_big_red_button_pressed()
	
	if Input.is_action_just_pressed("Check_Info"):
		_on_file_button_pressed()
		
	if Input.is_action_just_pressed("Select_A"):
		change_selection($"../SpawnA")
		
	if Input.is_action_just_pressed("Select_B"):
		change_selection($"../SpawnB")
		
	if Input.is_action_just_pressed("Replay_Joke"):
		replay_joke(selected_char)

func replay_joke(selected: Node3D):
	selected.get_child(0).get_node("AnimationPlayer").play("point")

func change_selection (selected :Node3D):
	selected_char = selected
	Spotlight.position = selected.position + Vector3(0, 0, 1)
	
	
func updateFileWindow():
	
	pass



func _on_big_red_button_pressed():
	var news = newspaper.instantiate()
	var buzz = get_parent().get_parent().get_child(0)
	buzz.buzzLightsOn(1, false)
	get_parent().get_parent().add_child(news)
	
	if Game.state == 0:
		if selected_char == $"../SpawnA" :
			Game.RoastPair[0] = Game.charMatchup[0]
			news.updateNewspaper( Game.charPool[Game.charMatchup[0]], Game.charPool[Game.charMatchup[1]])
		else:
			Game.RoastPair[0] = Game.charMatchup[1]
			news.updateNewspaper(Game.charPool[Game.charMatchup[1]], Game.charPool[Game.charMatchup[0]])
	else: if Game.state == 1:
		if selected_char == $"../SpawnA" :
			Game.RoastPair[1] = Game.charMatchup[2]
			news.updateNewspaper( Game.charPool[Game.charMatchup[2]], Game.charPool[Game.charMatchup[3]])
		else:
			Game.RoastPair[1] = Game.charMatchup[3]
			news.updateNewspaper(Game.charPool[Game.charMatchup[3]], Game.charPool[Game.charMatchup[2]])
	else: if Game.state == 2:
		if selected_char == $"../SpawnA" :
			news.updateNewspaper( Game.charPool[Game.RoastPair[0]], Game.charPool[Game.RoastPair[1]])
		else:
			news.updateNewspaper(Game.charPool[Game.RoastPair[1]], Game.charPool[Game.RoastPair[0]])
		Game.RoastPair.clear()
	Game.state = (Game.state + 1) % 3
	
	get_parent().get_parent().remove_child(get_parent())
	

func _on_file_button_pressed():
	$FileWindow.visible = !$FileWindow.visible

