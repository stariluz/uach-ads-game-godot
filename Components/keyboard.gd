extends Control

signal key_clicked(key:String)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	pass


func _on_a_key_clicked(key:String):
	emit_signal("key_clicked",key)
	print_debug(key)
