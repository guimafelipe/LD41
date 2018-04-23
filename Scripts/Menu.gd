extends Control

func _ready():
	if(GlobalData.lost_state):
		show_game_over()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func call_start_game():
	get_tree().change_scene("res://Scenes/Main.tscn")

func show_credits():
	$Credits.show()

func hide_credits():
	$Credits.hide()

func show_game_over():
	$GameOver.show()

func hide_game_over():
	$GameOver.hide()

func quit_game():
	get_tree().quit()