extends Node2D

@export var FILE_NAME="scores_heap.json"
signal score_update()
signal hangman_update(attempts: int)
signal resetGame()

var pointsPerGroup:Dictionary={
	"group_1": 10,
	"group_2": 20,
	"group_3": 30,
	"group_4": 40,
	"group_5": 50,
}
var letterGroup: Dictionary = {
	"A": "group_1",
	"B": "group_2",
	"C": "group_2",
	"D": "group_2",
	"E": "group_1",
	"F": "group_4",
	"G": "group_3",
	"H": "group_3",
	"I": "group_1",
	"J": "group_4",
	"K": "group_5",
	"L": "group_1",
	"M": "group_3",
	"N": "group_1",
	"Ñ": "group_5",
	"O": "group_1",
	"P": "group_3",
	"Q": "group_4",
	"R": "group_1",
	"S": "group_1",
	"T": "group_2",
	"U": "group_1",
	"V": "group_3",
	"W": "group_5",
	"X": "group_5",
	"Y": "group_3",
	"Z": "group_5",
}
var currentScore=Score.new()
var scoresHeap:ScoresHeap

var attempts: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	scoresHeap=load_score()
	if !scoresHeap:
		scoresHeap=ScoresHeap.new()
#	print_debug("DEV - ScoreManager - scoresHeap:", scoresHeap)
#	print_debug("DEV - ScoreManager - scoresHeap.length:", scoresHeap.scoresHeapLength)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func reset():
	attempts = 0
	currentScore=Score.new()
	resetGame.emit()
	
func setScoreWord(word:String):
	currentScore.word=word
	
func getScorelist():
	return scoresHeap.getSortedScores()
	
func on_word_initialized(word: String):
	currentScore.word=word
	
func on_bad_attempt(letter: String):
	attempts += 1
	
	if attempts != 7:
		hangman_update.emit(attempts)
	else:
		on_lose()
	
func on_good_attempt(letter: String):
	# @todo Calculate the score of the word.
	pass
	
func on_win():
	currentScore.value = calculateScore(currentScore.value, currentScore.word)
	
	scoresHeap.registerScore(currentScore)
	
#	print_debug("DEV - ScoreManager - on_win - Sorted scores:", scoresHeap.getSortedScores())
	save_score(scoresHeap)
	emit_signal('score_update')
	reset()
	
func on_lose():
	$"../GameOverScreen".visible = true
	
func load_score():
	if not FileAccess.file_exists(FILE_NAME):
#		print_debug("DEV - ScoreManager - loadScore:", "File hasn't been created")
		return null # Error! We don't have a save to load.
	var save_game = FileAccess.open(FILE_NAME, FileAccess.READ)
	var json_string = save_game.get_line()
	var json = JSON.new()
	var parse_result = json.parse(json_string)
	if not parse_result == OK:
		print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
		return null

	# Get the data from the JSON object
	var score_data = json.get_data()
	save_game.close()
	return ScoresHeap.load(score_data)
	
func save_score(scoresHeap:ScoresHeap):
	var save_game = FileAccess.open(FILE_NAME, FileAccess.WRITE)
	var json_string =JSON.stringify(scoresHeap.save())
	save_game.store_line(json_string)
	save_game.close()
	
func calculateScore(initialScore: int, word: String) -> int:
	#1 10 points per letter
	initialScore += (len(word) * 10)
	
	#2 Points relative to the rarity of the word
	for i in range( len(word) ):
		initialScore += pointsPerGroup [ letterGroup[ word[i].to_upper() ] ]
	
	#3 Each second left = 1 point
	initialScore += int($"../TimePanel".time)
	
	#4 20 points if number of attempts is 0. On the contrary, 20 points subtracted for each attempt
	if attempts == 0:
		initialScore += 20
	else:
		initialScore -= (20 * attempts)
	
	return initialScore


func _on_time_panel_time_is_up():
	on_lose()
