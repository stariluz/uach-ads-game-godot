extends Node2D
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


# Called when the node enters the scene tree for the first time.
func _ready():
	pass  # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func on_good_attempt(letter: String):
	pass
	
func on_win(word: String):
	pass
	
func on_lose(word: String):
	pass
