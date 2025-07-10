extends Control


func _on_back_button_pressed():
	Global.ClickSound.play()
	get_tree().change_scene_to_file("res://UI/menu.tscn")
