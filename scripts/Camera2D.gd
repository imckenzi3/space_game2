extends Camera2D

func _unhandled_input(event):
	if event.is_action_pressed("zoom_in"):
		self.zoom -= Vector2(0.1, 0.1)
	if event.is_action_pressed("zoom_out"):
		self.zoom += Vector2(0.1, 0.1)
 
 
