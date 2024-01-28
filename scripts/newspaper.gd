extends Node2D

var menu = preload("res://scenes/main_menu.tscn")
var vscreen = preload("res://scenes/vsscreen.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("Fadein")


func updateNewspaper(winner : CharacterInfo, loser : CharacterInfo):
	$ImageWinner.texture = winner.headline_win.image
	$ImageLoser.texture = loser.headline_loss.image
	


func _on_animation_player_animation_finished(anim_name):
	var scene
	if (Game.state == 0):
		scene = menu.instantiate()
	else:
		scene = vscreen.instantiate()
	
	get_parent().add_child(scene)
	get_parent().remove_child(self)
