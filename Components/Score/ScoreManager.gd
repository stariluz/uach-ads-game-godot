extends Node2D

@export var FILE_NAME="scores_heap.json"
var pointsPerGroup:Dictionary={
	"group_1": 100,
	"group_2": 200,
	"group_3": 300,
	"group_4": 400,
	"group_5": 500,
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

# Called when the node enters the scene tree for the first time.
func _ready():
	scoresHeap=load_score()
	if !scoresHeap:
		scoresHeap=ScoresHeap.new()
#	print_debug("DEV - ScoreManager - scoresHeap:", scoresHeap)
#	print_debug("DEV - ScoreManager - scoresHeap.length:", scoresHeap.scoresHeapLength)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func setScoreWord(word:String):
	currentScore.word=word
	
func getScorelist():
	print_debug("DEV - ScoreManager - getScorelist: ", scoresHeap.getSortedScores())
	print_debug("DEV - ScoreManager - getScorelist: ", scoresHeap.getSortedScores())
	return scoresHeap.getSortedScores()
	
func on_word_initialized(word: String):
	currentScore.word=word
	
func on_bad_attempt(letter: String):
	# @todo Recalculate the score of the word.
	pass
	
func on_good_attempt(letter: String):
	# @todo Calculate the score of the word.
	pass
	
func on_win():
	# @todo Recalculate the score of the word.
	scoresHeap.registerScore(currentScore)
#	print_debug("DEV - ScoreManager - on_win - Sorted scores:", scoresHeap.getSortedScores())
	save_score(scoresHeap)
	
func on_lose():
	pass
	
func load_score():
	if not FileAccess.file_exists(FILE_NAME):
		print_debug("DEV - ScoreManager - loadScore:", "File hasn't been created")
		return # Error! We don't have a save to load.
	var save_game = FileAccess.open(FILE_NAME, FileAccess.READ)
	var json_string = save_game.get_line()
	var json = JSON.new()
	var parse_result = json.parse(json_string)
	if not parse_result == OK:
		print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
		return null

	# Get the data from the JSON object
	var score_data = json.get_data()
	
	print_debug("DEV - ScoreManager - loadScore - ScoresHeap", score_data)
	return ScoresHeap.load(score_data)
	save_game.close()
	
func save_score(scoresHeap:ScoresHeap):
	print_debug("DEV - ScoreManager - save_score", scoresHeap.scoresHeap)
	var save_game = FileAccess.open(FILE_NAME, FileAccess.WRITE)
	var json_string =JSON.stringify(scoresHeap.save())
	save_game.store_line(json_string)
	save_game.close()

