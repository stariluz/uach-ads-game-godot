extends Resource

class_name Score

@export var value:int=0
@export var word:String=""

func save():
	var data={
		'value': value,
		'word': word,
	}
	return data


static func load(data)->Score:
	var score=Score.new()
	score.value=data.value
	score.word=data.word
	return score
