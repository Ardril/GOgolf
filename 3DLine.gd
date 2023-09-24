extends MeshInstance3D


# Called when the node enters the scene tree for the first time.
func _ready():
	var mesh = ArrayMesh.new()
	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES,
								 PlaneMesh.new().get_mesh_arrays())
	var mdt = MeshDataTool.new()
	mdt.create_from_surface(mesh, 0)
	# mesh is now a data structure
	
	for i in range(mdt.get_vertex_count()):
		var vertex = mdt.get_vertex(i)
		print("Vertex",i,"is at",vertex.x,"",vertex.y,"",vertex.y)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
