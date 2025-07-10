extends Node

# nodes
@onready var MoveSound = $Sounds/MoveSound
@onready var WinSound = $Sounds/WinSound
@onready var LoseSound = $Sounds/LoseSound
@onready var ClickSound = $Sounds/ClickSound

var board = [
	[0, 1, 2],
	[3, 4, 5],
	[6, 7, 8],
]

var empty_box_index = [0, 1]

var nums_array = range(0, 9)
var total_chances = 75
var chances_left = total_chances
var last_game_status = null


func reset_game():
	chances_left = total_chances


func swap(cell1_list, cell2_list):
	var cell1 = board[cell1_list[0]][cell1_list[1]]
	var cell2 = board[cell2_list[0]][cell2_list[1]]
	
	cell1 = cell1 + cell2
	cell2 = cell1 - cell2
	cell1 = cell1 - cell2
	
	board[cell1_list[0]][cell1_list[1]] = cell1
	board[cell2_list[0]][cell2_list[1]] = cell2


# Function to generate a solvable 8 puzzle board
func randomize_board():
	var values = [0, 1, 2, 3, 4, 5, 6, 7, 8]
	var n = values.size()

	# Shuffle the values randomly
	for i in range(n - 1, 0, -1):
		var j = randi() % (i + 1)
		swap2(values, i, j)

	# Check if the number of inversions is odd
	while count_inversions(values) % 2 != 0:
		values.shuffle()

	# Populate the board with the solvable configuration
	for i in range(3):
		for j in range(3):
			board[i][j] = values[i * 3 + j]
	
	for r in range(len(board)):
		for c in range(len(board[r])):
			if (board[r][c] == 0):
				empty_box_index = [r, c]
				return


# Function to count inversions
func count_inversions(arr):
	var inv_count = 0
	for i in range(arr.size()):
		for j in range(i + 1, arr.size()):
			if arr[i] > 0 and arr[j] > 0 and arr[i] > arr[j]:
				inv_count += 1
	return inv_count


func swap2(arr, index1, index2):
	var temp = arr[index1]
	arr[index1] = arr[index2]
	arr[index2] = temp
