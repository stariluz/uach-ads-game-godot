extends Control

@export var scoreManager:Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
#	var scoreList=scoreManager.getScorelist()
#	print_debug(scoreList)
#	renderScores(scoreList)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func onRefreshScores():
	var scoreList=scoreManager.getScorelist()
	renderScores(scoreList)

func renderScores(scoreList:Array):
	var scoreLabel=get_node("Score")
	var text=""
	var format_string="%s: %d\n"
	for score in scoreList:
		text=text+format_string % [score.word, score.value]
	scoreLabel.text=text
