extends Control
signal disableLetter(letterToDisable: String)

const words:Array[String]=[
	"parangacutimicuaro",
	"contrarrevolucionario",
	"mitocondria",
	"aeropuerto",
	"alabasta",
	"animal",
	"pelota",
	"conceptos",
	"esternocleidomastoideo"
];

var usedLetters = {
	"A": false,
	"B": false,
	"C": false,
	"D": false,
	"E": false,
	"F": false,
	"G": false,
	"H": false,
	"I": false,
	"J": false,
	"K": false,
	"L": false,
	"M": false,
	"N": false,
	"Ñ": false,
	"O": false,
	"P": false,
	"Q": false,
	"R": false,
	"S": false,
	"T": false,
	"U": false,
	"V": false,
	"W": false,
	"X": false,
	"Y": false,
	"Z": false,
}

signal on_good_attempt(letter:String)
signal on_bad_attempt(letter:String)
signal on_win()
signal on_word_initialized(word:String)

@export var WORD_WIDTH:float=1520
@export var LETTER_FREESPACE_ASPECT_RATIO:float=0.1
@export var currentWord:String=""
@export var nodeReceptor:Control

var tryWord:String=""
var letterBoxUIScene
var lettersBoxUIIntances:Array=[]

# Called when the node enters the scene tree for the first time.
func _ready():
	letterBoxUIScene=preload("res://Components/Word/letter_box_ui.tscn")
	initWord()
	renderWordUI();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func initWord():
	initUsedLetters()
	var randomIndex = randi() % words.size()
	currentWord = words[randomIndex]
	print("Randomly selected word: ", currentWord)
	tryWord=hideWord(currentWord)
	emit_signal('on_word_initialized', currentWord)
	
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
		
	var horizontal_offset=WORD_WIDTH/2
	var vertical_offset=boxWidth/2
#
	nodeReceptor.anchor_left = 0.5
	nodeReceptor.anchor_right = 0.5
	nodeReceptor.anchor_top = 0.5
	nodeReceptor.anchor_bottom = 0.5
	nodeReceptor.offset_left = -horizontal_offset
	nodeReceptor.offset_right = horizontal_offset
	nodeReceptor.offset_top = -vertical_offset
	nodeReceptor.offset_bottom = vertical_offset

func initNodesLabels():
	lettersBoxUIIntances=[]
	
	var children = nodeReceptor.get_children()
	for child in children:
		nodeReceptor.remove_child(child)
	
	# This is ereasing the word. I don't know if it's necesary
#	if is_instance_valid(nodeReceptor):
#		nodeReceptor.queue_free()

func renderLetterBoxUI(letter:String, horizontalPosition:int, horizontalSize: float):
	var lbUIInstance = letterBoxUIScene.instantiate()

	nodeReceptor.add_child(lbUIInstance)
	lbUIInstance.get_node("Letter").text=letter;
	var new_position = Vector2(horizontalPosition, 0)
	var scaleMultiplier=horizontalSize/lbUIInstance.size.x
	lbUIInstance.position = new_position
	lbUIInstance.scale=Vector2(scaleMultiplier, scaleMultiplier)
	
	lettersBoxUIIntances.push_back(lbUIInstance)
	
func rerenderLetterBoxUI(index:int, letter:String):
	lettersBoxUIIntances[index].get_node("Letter").text=letter

func onAttempt(attempt_letter:String):
	print_debug(nodeReceptor.get_children())
	if(usedLetters[attempt_letter]):
		print_debug("Letter already tried")
		return
	
	disableLetter.emit(attempt_letter)
	
	usedLetters[attempt_letter]=true
	var isGoodAttempt=false
	
	for letter in tryWord:
		if letter.to_upper()==attempt_letter.to_upper():
			return isGoodAttempt
			
	for i in range(currentWord.length()):
		if currentWord[i].to_upper()==attempt_letter.to_upper():
			tryWord[i]=attempt_letter.to_upper();
			rerenderLetterBoxUI(i, attempt_letter)
			isGoodAttempt=true
	if(isGoodAttempt):
		if(hasWon()):
			onWin()
		onGoodAttempt(attempt_letter)
	else:
		onBadAttempt(attempt_letter)
		
	return isGoodAttempt
	
func hasWon():
	var hasWin=true
		
	for i in range(currentWord.length()):
		if currentWord[i].to_upper() != tryWord[i].to_upper():
			hasWin=false
	return hasWin

func initUsedLetters():
	usedLetters = {
		"A": false,
		"B": false,
		"C": false,
		"D": false,
		"E": false,
		"F": false,
		"G": false,
		"H": false,
		"I": false,
		"J": false,
		"K": false,
		"L": false,
		"M": false,
		"N": false,
		"Ñ": false,
		"O": false,
		"P": false,
		"Q": false,
		"R": false,
		"S": false,
		"T": false,
		"U": false,
		"V": false,
		"W": false,
		"X": false,
		"Y": false,
		"Z": false,
	}

func onWin():
	emit_signal("on_win");
	initNodesLabels()
	initWord()
	renderWordUI()
	
func onGoodAttempt(letter:String,):
	emit_signal("on_good_attempt", letter);
	
func onBadAttempt(letter:String,):
	emit_signal("on_bad_attempt", letter);
	

