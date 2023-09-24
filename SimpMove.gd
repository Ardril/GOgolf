extends RigidBody3D

var pressed_on = false
var speed = 20.0
var line
var camera
var ray
# Called when the node enters the scene tree for the first time.
func _ready():
	$CameraRig.top_level = true
	camera = $CameraRig/Camera3D
	ray = $CameraRig/Camera3D/RayCast3D
	pass # Replace with function body.


func lineZiehen(world: World3D):
	var y_offset = 0
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	
	var position2D = get_viewport().get_mouse_position()
	
	
	var dropPlane  = Plane(Vector3(0, 10, 0))
	var position3D = dropPlane.intersects_ray(camera.project_ray_origin(position2D),camera.project_ray_normal(position2D))
	
	
	
	#maus ziehen
	var mousepos = get_viewport().get_mouse_position()
	var mousePos3D = Vector3(mousepos.x,mousepos.y,position.z)
	
	#mesh gen
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_add_vertex(position)
	immediate_mesh.surface_add_vertex(position3D)
	immediate_mesh.surface_end()
	
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.DARK_GREEN
	line = mesh_instance
	add_child(line)
	# NOT SHOWING WHY THE FUCK 
	return mesh_instance
	
	
	
#begin: Vector3,end: Vector3
func ebeneZiehen():
	#if line:
	#	line.queue_free()
	var y = 0
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	

	
	#Maus shit
	var mousepos = get_viewport().get_mouse_position()
	var aufMausZeigVektor = Vector3(mousepos.x-position.x,y,mousepos.y-position.y)
	
	#var rp = Vector3(position.x+aufMausZeigVektor.rotated(Vector3(0,1,0),90).x,y,position.z+aufMausZeigVektor.rotated(Vector3(0,1,0),90).z)
					
	var rightPoint = position + (aufMausZeigVektor*Vector3.RIGHT)
	
	#var lp = Vector3(position.x+aufMausZeigVektor.rotated(Vector3(0,1,0),-90).z,y,position.z+aufMausZeigVektor.rotated(Vector3(0,1,0),-90).z)
					
	var leftPoint = position + (aufMausZeigVektor*Vector3.LEFT)
	
	var extlp = position + (aufMausZeigVektor*0.5+rightPoint)
	var extrp = position + (aufMausZeigVektor*0.5+leftPoint)
	
	print("ball pos:",position)
	print("MouseVektor:",aufMausZeigVektor)
	print("leftpoint:",leftPoint)
	print("ext leftpoint:",extlp)
	print("ext rightpoint:",extrp)
	print("rightpoint:",rightPoint)
	
	#mesh gen
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_add_vertex(leftPoint)
	immediate_mesh.surface_add_vertex(extlp)
	immediate_mesh.surface_add_vertex(extrp)
	immediate_mesh.surface_add_vertex(rightPoint)
	immediate_mesh.surface_end()
	
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.DARK_GREEN
	line = mesh_instance
	add_child(line)
	# NOT SHOWING WHY THE FUCK 
	return mesh_instance

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	$CameraRig.global_transform.origin = global_transform.origin
	
	if Input.is_action_pressed("ui_up"):
			print(position)
			angular_velocity.x -= speed*delta
			
	elif Input.is_action_pressed("ui_down"):
			print(position)
			angular_velocity.x += speed*delta
			
	elif Input.is_action_pressed("ui_right"):
			print(position)
			angular_velocity.z -= speed*delta
			
	elif Input.is_action_pressed("ui_left"):
			print(position)
			angular_velocity.z += speed*delta
			
	#print("Mouse_state:",pressed_on)
	if pressed_on:
		lineZiehen(get_world_3d())
		print("line spawned")
		print("Children :",get_child_count())
		
		
	pass 
	
func _input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT :
		if event.is_pressed() :
			pressed_on = true
			print("Mouse clicked at", event.position)
		
func _input(event):
	if event is InputEventMouseButton \
	and event.button_index == 1 \
	and not event.is_pressed():
		pressed_on = false
		print("Mouse released at", event.position)
		print("Children after release",get_child_count())


