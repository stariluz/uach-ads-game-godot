extends Control

signal key_clicked(key:String)
# Called when the node enters the scene tree for the first time.
func _ready():
	initKeyboard()

func _process(delta):
	pass


func _on_a_key_clicked(key:String):
	emit_signal("key_clicked",key)

func initKeyboard():
	var rows=get_children()
	for row in rows:
		var keys=row.get_children()
		for key in keys:
			key.set_key_as_unclicked()
#			print_debug(key.clicked)
	
