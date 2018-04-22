extends KinematicBody

var camera_angle = 0
var mouse_sensitivity = 0.3
var camera_change = Vector2()

var velocity = Vector3()
var direction = Vector3()

#shoot variables

var shoot_range = 1000
var camera_width_center = 0
var camera_height_center = 0
var shoot_origin = Vector3()
var shoot_normal = Vector3()
var shooting = 0

#variables from official FPS tutorial
var current_gun = "UNARMED"
var changing_gun = false

#var bullet_scene = preload("Bullet.tscn")
enum {PIZZA, HAMBURGUER, HOTDOG} #Botar isso numa variável global
#var bullet_scene = preload("PizzaBullet.tscn")
var bullet_scenes = [preload("res://Scenes/PizzaBullet.tscn"),
preload("res://Scenes/BurguerBullet.tscn"),
preload("res://Scenes/HotdogBullet.tscn")
]
var bullet_placeholders = [preload("res://Scenes/PizzaPlaceholder.tscn"),
preload("res://Scenes/BurguerPlaceholder.tscn"),
preload("res://Scenes/HotdogPlaceholder.tscn")
]
var current_bullet = -1

onready var spawnerClass = preload("res://Scripts/Spawner.gd")

func _ready():
	camera_width_center = OS.get_window_size().x / 2
	camera_height_center = OS.get_window_size().y / 2
	
	pass

func _physics_process(delta):
	aim()
	
	if shooting > 0:
#		fire_bullet()
		var space_state = get_world().direct_space_state
		var result = space_state.intersect_ray(shoot_origin, shoot_normal, [self], 1)
		var impulse
		var impact_position
		if result:
			print(result.collider)
			impulse = (result.position - global_transform.origin).normalized()
			impact_position = result.position
			var position = result.position - result.collider.global_transform.origin
#			if shooting == 1 and result.collider is RigidBody:
#				result.collider.apply_impulse(position, impulse * 10)
			if shooting == 1 and result.collider is spawnerClass:
				current_bullet = result.collider.foodType
				load_placeholder()
			else:
				fire_bullet()
		else:
			fire_bullet()
	shooting = 0

func load_placeholder():
	# check current_bullet value and load correspondent placeholder
	
	var phld_point = $Head/Camera/PlaceholderPoint
	if phld_point.get_child_count() > 0: #deveria sempre ser o caso
		phld_point.get_child(0).queue_free()
	
	var ph = bullet_placeholders[current_bullet].instance()
	phld_point.add_child(ph)
	pass

func _input(event):
	if event is InputEventMouseMotion:
		camera_change = event.relative
		
	if event is InputEventMouseButton and event.is_pressed():
		var camera = $Head/Camera
		shoot_origin = camera.project_ray_origin(Vector2(camera_width_center, camera_height_center))
		shoot_normal = camera.project_ray_normal(Vector2(camera_width_center, camera_height_center)) * shoot_range
		if event.button_index == 1:
			shooting = 1
		if event.button_index ==2:
			shooting = 2
		
		
func aim():
	if camera_change.length() > 0:
		$Head.rotate_y(deg2rad(-camera_change.x * mouse_sensitivity))

		var change = -camera_change.y * mouse_sensitivity
		if change + camera_angle < 90 and change + camera_angle > -90:
			$Head/Camera.rotate_x(deg2rad(change))
			camera_angle += change
		camera_change = Vector2()

func fire_bullet():
	if current_bullet == -1:
		return
	var clone = bullet_scenes[current_bullet].instance()
	current_bullet = -1
	
	remove_placeholder()
	
	var scene_root = get_tree().root.get_children()[0]
	
	scene_root.add_child(clone)
	clone.global_transform = get_node("Head/Camera/Gun_fire_point").global_transform
	clone.init()

func remove_placeholder():
	var phld_point = $Head/Camera/PlaceholderPoint
	if phld_point.get_child_count() > 0: #deveria sempre ser o caso
		phld_point.get_child(0).queue_free()
