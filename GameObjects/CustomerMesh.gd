extends MeshInstance

func _ready():
	pass

func updateMesh(remainingTime):
	var toRed = clamp(remainingTime/15.0, 0, 1)
	var color = Color(1, toRed, toRed)
	get_surface_material(0).set_shader_param("albedo", color)
