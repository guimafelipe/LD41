extends MeshInstance

func updateMesh(remainingTime):
	var toRed = clamp(remainingTime/15.0, 0, 1)
	var color = Color(1, toRed, toRed)
	get_surface_material(1).set_shader_param("albedo", color)
