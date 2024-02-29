extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	
	var charA
	var charB
	
	if Game.state == 0:
		charA = Game.charPool[Game.charMatchup[0]].model.instantiate()
		charB = Game.charPool[Game.charMatchup[1]].model.instantiate()
	else: if Game.state == 1:
		charA = Game.charPool[Game.charMatchup[2]].model.instantiate()
		charB = Game.charPool[Game.charMatchup[3]].model.instantiate()
	else: if Game.state == 2:
		charA = Game.charPool[Game.RoastPair[0]].model.instantiate()
		charB = Game.charPool[Game.RoastPair[1]].model.instantiate()
	$SpawnA.add_child(charA)
	$SpawnB.add_child(charB)
	
	charA.position.y -= 1.5
	charB.position.y -= 1.5
	
	var animA = $SpawnA.get_child(0).get_node("AnimationPlayer")
	var animB = $SpawnB.get_child(0).get_node("AnimationPlayer")
	
	
	animA.animation_finished.connect(change_spotlight_on_start, 4)
	animB.animation_finished.connect(start_input, 4)
	
	if Game.state == 2:
		$AudioStreamPlayer2D.stream = load("res://audio/aggro disco.mp3")
	else :
		$AudioStreamPlayer2D.stream = load("res://audio/disco ggj2024.mp3")
	
	$AudioStreamPlayer2D.play()

func start_input( randstring : String):
	var buzz = get_parent().get_child(0)
	buzz.buzzLightsOn(1, true)
	$HUD.set_process(true)

func change_spotlight_on_start( randstring : String):
	$SpawnB.get_child(0).get_node("AnimationPlayer").play("Joke")
	$HUD.change_selection($SpawnB)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_animation_player_animation_finished(anim_name):
	$SpawnA.get_child(0).get_node("AnimationPlayer").play("Joke")
	
