extends Control

const words:Array[String]=[
	"parangacutimicuaro",
	"electrocamaleon",
	"mitocondria",
	"aeropuerto",
	"alabasta",
	"animal",
	"pelota",
	"conceptos",
];
@export var WORD_WIDTH:float=1520
@export var LETTER_FREESPACE_ASPECT_RATIO:float=0.1
@export var currentWord:String=""
var tryWord:String=""
var letterBoxUIScene
var lettersBoxUIIntances:Array=[]

# Called when the node enters the scene tree for the first time.
func _ready():
	letterBoxUIScene=preload("res://Components/WordGeneration/letter_box_ui.tscn");
	var randomIndex = randi() % words.size()
	currentWord = words[randomIndex]
	print("Randomly selected word: ", currentWord)
	tryWord=hideWord(currentWord);
	renderWordUI();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func hideWord(word:String):
	var hidenWord=""
	for i in word:
		hidenWord+=" "
	return hidenWord
	
func renderWordUI():
	var length=tryWord.length()
	var boxWidth=(WORD_WIDTH/(LETTER_FREESPACE_ASPECT_RATIO*(length-1)+length))
	var freeSpace=boxWidth*LETTER_FREESPACE_ASPECT_RATIO;
	
	for i in range(length):
		renderLetterBoxUI(tryWord[i].to_upper(), (boxWidth+freeSpace)*i, boxWidth)

func renderLetterBoxUI(letter:String, horizontalPosition:int, horizontalSize: float):
	var lbUIInstance = letterBoxUIScene.instantiate()
	add_child(lbUIInstance)
	
	lbUIInstance.get_node("Letter").text=letter;
	var new_position = Vector2(horizontalPosition, 0)
	var scaleMultiplier=horizontalSize/lbUIInstance.size.x
	lbUIInstance.position = new_position
#	print_debug("DEV - size ",lbUIInstance.size)
	
	lbUIInstance.scale=Vector2(scaleMultiplier, scaleMultiplier)
#	print_debug("DEV - scale ",lbUIInstance.scale)
	
	lettersBoxUIIntances.push_back(lbUIInstance)
	
func rerenderLetterBoxUI(index:int, letter:String):
	print_debug(lettersBoxUIIntances[index])
	lettersBoxUIIntances[index].get_node("Letter").text=letter

func onTry(key:String):
	print_debug("TRY", key)
	var isRightTry=false
	
	for letter in tryWord:
		if letter.to_upper()==key.to_upper():
			print_debug(letter, " ", key)
			return
			
	for i in range(currentWord.length()):
		print_debug(currentWord[i], " ", key)
		if currentWord[i].to_upper()==key.to_upper():
			tryWord[i]=key;
			rerenderLetterBoxUI(i, key)
			isRightTry=true

	return isRightTry
