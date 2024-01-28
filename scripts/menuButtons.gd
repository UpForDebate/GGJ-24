extends Node

@onready var intro = preload("res://scenes/vsscreen.tscn")

func _ready():
	get_parent().reset()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Select_A"):
		play_game()
	if Input.is_action_just_pressed("Select_B"):
		exit_game()


func play_game():
	get_parent().add_child(intro.instantiate())
	get_parent().remove_child(self)

func exit_game():
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()

func _on_play_button_pressed():
	play_game()


func _on_exit_button_pressed():
	exit_game()
