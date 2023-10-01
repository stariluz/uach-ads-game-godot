extends TextEdit


# Called when the node enters the scene tree for the first time.
func _ready():
#	theme.background_color=Color(0,0,0,0)
	print_debug(text)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_text_changed():
	if(text):
		text=text[0]
	print_debug(text)
	pass # Replace with function body.
