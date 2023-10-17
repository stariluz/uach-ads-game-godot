extends Node2D

# Expose a variable for the Label text
@export var letterText:String = "A"
@export var keyboard:Node2D
@export var clicked:bool=false

signal key_clicked(key:String)

func _ready():
	# Use get_node to get a reference to the Label node by its full path
	var label_node = get_node("TextureButton/Label")

	if label_node:
		label_node.text=letterText
	else:
		print_debug("DEV - key_button - _ready(): Label node not founded")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_texture_button_pressed():
	if(!clicked):
		emit_signal("key_clicked",letterText)
		set_key_as_clicked()
	else:
		print_debug("Key ",letterText," already clicked")

func set_key_as_clicked():
	clicked=true
	
func set_key_as_unclicked():
	clicked=false
