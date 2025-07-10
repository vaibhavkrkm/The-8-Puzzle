extends Control


func _ready():
	if (Global.last_game_status == "win"):
		$Overlay.visible = true
		$WinUI.visible = true
		$WinUI/MovesLabel.text = "You solved in: " + str(Global.total_chances - Global.chances_left) + " moves!"
		$LoseUI.visible = false
	elif (Global.last_game_status == "lose"):
		$Overlay.visible = true
		$LoseUI.visible = true
		$WinUI.visible = false
	else:
		$Overlay.visible = false
		$WinUI.visible = false
		$LoseUI.visible = false
	
	Global.reset_game()
	Global.last_game_status = null


func _on_quit_pressed():
	Global.ClickSound.play()
	get_tree().quit()


func _on_play_pressed():
	Global.ClickSound.play()
	get_tree().change_scene_to_file("res://Level/level.tscn")


func _on_how_to_play_pressed():
	Global.ClickSound.play()
	
	get_tree().change_scene_to_file("res://UI/how_to_play.tscn")


func _on_play_mouse_entered():
	$Buttons/Play/Label.visible = true


func _on_play_mouse_exited():
	$Buttons/Play/Label.visible = false


func _on_how_to_play_mouse_entered():
	$Buttons/HowToPlay/Label.visible = true


func _on_how_to_play_mouse_exited():
	$Buttons/HowToPlay/Label.visible = false


func _on_quit_mouse_entered():
	$Buttons/Quit/Label.visible = true


func _on_quit_mouse_exited():
	$Buttons/Quit/Label.visible = false


func _on_continue_button_pressed():
	$WinUI.visible = false
	$LoseUI.visible = false
	$Overlay.visible = false
