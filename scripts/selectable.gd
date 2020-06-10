extends RigidBody

class_name Selectable

var gui

func _ready():
	gui = preload("edit_planet_gui.gd")
	gui = gui.new(self)
	add_child(gui)

func _on_input_event(camera, event, click_position, click_normal, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			gui.show()
