extends LineEdit


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_text_changed(new_text:String):
	print_debug(text, new_text)
	if(text):
		text=text[0]
	print_debug(text)
	pass # Replace with function body.
