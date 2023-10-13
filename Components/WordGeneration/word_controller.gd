extends Node2D

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
@export var WORD_WIDTH:float=1520;
@export var LETTER_FREESPACE_ASPECT_RATIO:float=0.1;
@export var currentWord:String=""
@export var rowContainer:HBoxContainer;

var tryWord:String=""
var letterBoxUIScene;
# Called when the node enters the scene tree for the first time.
func _ready():
	letterBoxUIScene=preload("res://Components/WordGeneration/letter_box_ui.tscn");
	var randomIndex = randi() % words.size()
	currentWord = words[6]
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
	var length=currentWord.length()
#	var boxWidth=(WORD_WIDTH/(LETTER_FREESPACE_ASPECT_RATIO*(length-1)+length))
#	var freeSpace=boxWidth*LETTER_FREESPACE_ASPECT_RATIO;
#	print_debug("DEV ",length)
#
#	print_debug("DEV - length - boxWidt - freeSpace",length, " ", boxWidth," ", freeSpace)
	
	for i in range(length):
		renderLetterBoxUI(currentWord[i].to_upper())

func renderLetterBoxUI(letter:String):
	var lbUIInstance = letterBoxUIScene.instantiate()
	rowContainer.add_child(lbUIInstance)
	lbUIInstance.get_node("Letter").text=letter;
	
