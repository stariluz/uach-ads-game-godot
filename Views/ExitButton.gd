extends Button


func _input(event):
	if event is InputEventMouseButton:
		if (get_rect().has_point(event.position) && $"..".visible):
			get_tree().quit()
