extends Button
signal resetGame()

func _input(event):
	if event is InputEventMouseButton:
		if (get_rect().has_point(event.position) && $"..".visible):
			get_tree().reload_current_scene()
