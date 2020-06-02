extends Node

# Returs a vec_3 with foce
func grav_force(mass_1, mass_2, pos_1, pos_2):
	var gc = 6.67 * pow(10, -3)
	var dist_sq = (
	pow((pos_1.x - pos_2.x),2) +
	pow((pos_1.y - pos_2.y),2) +
	pow((pos_1.z - pos_2.z),2)
	)
	if dist_sq == 0:
		return Vector3(0, 0, 0)

	var force = (gc * mass_1 * mass_2) / dist_sq
	var vec =  (pos_2 - pos_1)
	var vec_force = vec * force


	return vec_force

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(a):
	for planet_1 in self.get_children():
		for planet_2 in self.get_children():
			var force = grav_force(planet_1.mass, planet_2.mass, planet_1.get_global_transform().origin, planet_2.get_global_transform().origin)
			planet_1.apply_central_impulse(force)
