extends Control

# Constant Gui Settings
#*******************************************************************************
const GUI_POS = Vector2(10, 10)
const GUI_SIZE = Vector2(200, 100)
const DRAGGABLE = true

const CUSTOM_BACKGROUND = false
const BACKGROUND_COLOR = Color(0.15, 0.17, 0.23, 0.75)
var enabled
var curr_planet
var labels = {}
var scale = 1

func _init(planet):
	enabled = 0
	curr_planet = planet
	scale = curr_planet.get_node("MeshInstance").scale.length()

func _ready():
	# Create Gui
	var panel = PanelContainer.new()
	panel.set_begin(GUI_POS)
	panel.set_custom_minimum_size(GUI_SIZE)

	if CUSTOM_BACKGROUND:
		var style = StyleBoxFlat.new()
		style.set_bg_color(BACKGROUND_COLOR)
		style.set_expand_margin_all(5)
		panel.add_stylebox_override("panel", style)

	var container = VBoxContainer.new()

	labels["title"] = Label.new()
	labels["title"].set_text("Edit planet - esc to exit")

	labels["mass"] = Label.new()
	labels["mass"].set_text("Mass -> " + str(curr_planet.get_mass()))

	var mass = HScrollBar.new()
	mass.set_max(65535)
	mass.set_min(0.01)
	mass.set_value(curr_planet.get_mass())
	mass.connect("value_changed", self, "_on_mass_value_changed")

	labels["scale"] = Label.new()
	labels["scale"].set_text("Scale -> " + str(scale))

	var sb_scale = SpinBox.new()
	sb_scale.set_max(65535)
	sb_scale.set_min(0.01)
	sb_scale.set_step(0.01)
	sb_scale.set_value(scale)
	sb_scale.connect("value_changed", self, "_on_scale_value_changed")

	labels["pos_x"] = Label.new()
	labels["pos_x"].set_text("x -> " + str(curr_planet.translation.x))
	var sl_pos_x = HScrollBar.new()
	sl_pos_x.set_max(5000)
	sl_pos_x.set_min(-5000)
	sl_pos_x.set_value(curr_planet.translation.x)
	sl_pos_x.connect("value_changed", self, "_on_pos_x_value_changed")

	labels["pos_y"] = Label.new()
	labels["pos_y"].set_text("y -> " + str(curr_planet.translation.y))
	var sl_pos_y = HScrollBar.new()
	sl_pos_y.set_max(5000)
	sl_pos_y.set_min(-5000)
	sl_pos_y.set_value(curr_planet.translation.y)
	sl_pos_y.connect("value_changed", self, "_on_pos_y_value_changed")


	labels["pos_z"] = Label.new()
	labels["pos_z"].set_text("z -> " + str(curr_planet.translation.z))
	var sl_pos_z = HScrollBar.new()
	sl_pos_z.set_max(5000)
	sl_pos_z.set_min(-5000)
	sl_pos_z.set_value(curr_planet.translation.z)
	sl_pos_z.connect("value_changed", self, "_on_pos_z_value_changed")

	add_child(panel)
	panel.add_child(container)
	container.add_child(labels["title"])
	container.add_child(labels["mass"])
	container.add_child(mass)
	container.add_child(labels["scale"])
	container.add_child(sb_scale)
	container.add_child(labels["pos_x"])
	container.add_child(sl_pos_x)
	container.add_child(labels["pos_y"])
	container.add_child(sl_pos_y)
	container.add_child(labels["pos_z"])
	container.add_child(sl_pos_z)

	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	self.hide()

func _on_pos_x_value_changed(value):
	curr_planet.translation.x = value
	labels["pos_x"].set_text("x -> " + str(curr_planet.translation.x))

func _on_pos_y_value_changed(value):
	curr_planet.translation.y = value
	labels["pos_y"].set_text("y -> " + str(curr_planet.translation.y))

func _on_pos_z_value_changed(value):
	curr_planet.translation.z = value
	labels["pos_z"].set_text("z -> " + str(curr_planet.translation.z))

func _on_mass_value_changed(value):
	curr_planet.set_mass(value)
	labels["mass"].set_text("Mass - " + str(curr_planet.get_mass()))

func _on_scale_value_changed(value):
	scale = value
	scale_planet(scale)
	labels["scale"].set_text("Scale - " + str(scale))

func _input(_event):
	if Input.is_action_just_pressed("ui_cancel"):
			self.hide()

func scale_planet(rec_scale):
	var mesh = curr_planet.get_node("MeshInstance")
	var col_shape = curr_planet.get_node("CollisionShape")
	mesh.scale = mesh.scale.normalized() * rec_scale
	col_shape.scale = col_shape.scale.normalized() * rec_scale
