extends Node2D


@onready var stage = preload("res://scenes/stage.tscn")

func _ready():
	
	$AnimationPlayer.play("intro_anim")
	
	if Game.state == 0:
		$Control/LeftChar.texture = Game.charPool[Game.charMatchup[0]].versus_sprite
		$Control/RightChar.texture = Game.charPool[Game.charMatchup[1]].versus_sprite
	else: if Game.state == 1:
		$Control/LeftChar.texture = Game.charPool[Game.charMatchup[2]].versus_sprite
		$Control/RightChar.texture = Game.charPool[Game.charMatchup[3]].versus_sprite
	else: if Game.state == 2:
		$Control/LeftChar.texture = Game.charPool[Game.RoastPair[0]].versus_sprite
		$Control/RightChar.texture = Game.charPool[Game.RoastPair[1]].versus_sprite
	
	$AudioStreamPlayer2D.play(5.0)

func _on_animation_player_animation_finished(anim_name):
	get_parent().add_child(stage.instantiate())
	get_parent().remove_child(self)

