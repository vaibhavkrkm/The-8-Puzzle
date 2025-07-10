extends Control

@export var TWEENING_TIME: float

# nodes
@onready var BoardPositions = $BoardPositions
@onready var BoardCells = $BoardCells


func _ready():
	randomize()
	Global.randomize_board()
	$UI/ChancesLeftLabel.text = "Chances Left:\n" + str(Global.total_chances)
	for r in range(len(Global.board)):
		for c in range(len(Global.board[r])):
			var current_value = Global.board[r][c]
			if (current_value != 0):
				var current_cell = BoardCells.get_node("Cell" + str(current_value))
				var current_pos = BoardPositions.get_node("Pos" + str(r) + str(c)).position

				var tween = create_tween()
				tween.tween_property(current_cell, "position", current_pos, 0.8).from_current().set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)


func _process(delta):
	if (Input.is_action_just_pressed("down") and Global.chances_left > 0):
		update_board("down")
	elif (Input.is_action_just_pressed("up") and Global.chances_left > 0):
		update_board("up")
	elif (Input.is_action_just_pressed("right") and Global.chances_left > 0):
		update_board("right")
	elif (Input.is_action_just_pressed("left") and Global.chances_left > 0):
		update_board("left")


func game_lose():
	if (Global.chances_left <= 0):
		return true
	return false


func game_win():
	var count = 1
	for r in range(len(Global.board)):
		for c in range(len(Global.board[r])):
			if (Global.board[r][c] != count):
				return false
			if (count >= 8):
				return true
			count += 1


func game_status():
	if (game_win()):
		Global.WinSound.play()
		Global.last_game_status = "win"
		get_tree().change_scene_to_file("res://UI/menu.tscn")
	elif (game_lose()):
		Global.LoseSound.play()
		Global.last_game_status = "lose"
		get_tree().change_scene_to_file("res://UI/menu.tscn")


func update_board(dir):
	var empty_box_row_index = Global.empty_box_index[0]
	var empty_box_col_index = Global.empty_box_index[1]
	
	if (dir == "down"):
		if (empty_box_row_index > 0):
			# move down
			Global.MoveSound.play()
			var current_value = Global.board[empty_box_row_index-1][empty_box_col_index]
			var current_cell = BoardCells.get_node("Cell" + str(current_value))
			var current_pos = BoardPositions.get_node("Pos" + str(empty_box_row_index) + str(empty_box_col_index)).position
			var tween = create_tween()
			tween.tween_property(current_cell, "position", current_pos, TWEENING_TIME).from_current().set_trans(Tween.TRANS_BACK)
			tween.tween_callback(game_status).set_delay(TWEENING_TIME)
			Global.swap(Global.empty_box_index, [empty_box_row_index-1, empty_box_col_index])
			Global.empty_box_index[0] -= 1
			Global.chances_left -= 1
			$UI/ChancesLeftLabel.text = "Chances Left:\n" + str(Global.chances_left)
	elif (dir == "up"):
		if (empty_box_row_index < 2):
			# move up
			Global.MoveSound.play()
			var current_value = Global.board[empty_box_row_index+1][empty_box_col_index]
			var current_cell = BoardCells.get_node("Cell" + str(current_value))
			var current_pos = BoardPositions.get_node("Pos" + str(empty_box_row_index) + str(empty_box_col_index)).position
			var tween = create_tween()
			tween.tween_property(current_cell, "position", current_pos, TWEENING_TIME).from_current().set_trans(Tween.TRANS_BACK)
			tween.tween_callback(game_status).set_delay(TWEENING_TIME)
			Global.swap(Global.empty_box_index, [empty_box_row_index+1, empty_box_col_index])
			Global.empty_box_index[0] += 1
			Global.chances_left -= 1
			$UI/ChancesLeftLabel.text = "Chances Left:\n" + str(Global.chances_left)
	elif (dir == "right"):
		if (empty_box_col_index > 0):
			# move right
			Global.MoveSound.play()
			var current_value = Global.board[empty_box_row_index][empty_box_col_index-1]
			var current_cell = BoardCells.get_node("Cell" + str(current_value))
			var current_pos = BoardPositions.get_node("Pos" + str(empty_box_row_index) + str(empty_box_col_index)).position
			var tween = create_tween()
			tween.tween_property(current_cell, "position", current_pos, TWEENING_TIME).from_current().set_trans(Tween.TRANS_BACK)
			tween.tween_callback(game_status).set_delay(TWEENING_TIME)
			Global.swap(Global.empty_box_index, [empty_box_row_index, empty_box_col_index-1])
			Global.empty_box_index[1] -= 1
			Global.chances_left -= 1
			$UI/ChancesLeftLabel.text = "Chances Left:\n" + str(Global.chances_left)
	elif (dir == "left"):
		if (empty_box_col_index < 2):
			# move left
			Global.MoveSound.play()
			var current_value = Global.board[empty_box_row_index][empty_box_col_index+1]
			var current_cell = BoardCells.get_node("Cell" + str(current_value))
			var current_pos = BoardPositions.get_node("Pos" + str(empty_box_row_index) + str(empty_box_col_index)).position
			var tween = create_tween()
			tween.tween_property(current_cell, "position", current_pos, TWEENING_TIME).from_current().set_trans(Tween.TRANS_BACK)
			tween.tween_callback(game_status).set_delay(TWEENING_TIME)
			Global.swap(Global.empty_box_index, [empty_box_row_index, empty_box_col_index+1])
			Global.empty_box_index[1] += 1
			Global.chances_left -= 1
			$UI/ChancesLeftLabel.text = "Chances Left:\n" + str(Global.chances_left)


func _on_back_to_menu_button_pressed():
	Global.ClickSound.play()
	get_tree().change_scene_to_file("res://UI/menu.tscn")
