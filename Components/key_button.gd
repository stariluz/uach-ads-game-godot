extends Node2D

# Expose a variable for the Label text
@export var letterText:String = "A"

# Called when the node enters the scene tree for the first time.
func _ready():
	# Use get_node to get a reference to the Label node by its full path
	var label_node = get_node("TextureButton/Label")

	if label_node:
		label_node.text=letterText
	else:
		print("Label node not found")



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
