
extends RigidBody


#const BULLET_SPEED = 80
const KILL_TIMER = 4 #tempo pra bala sumir
var timer = 0 #A float for tracking how long we’ve been alive. Pode ser útil

var hit_something = false
var throwImpulse = 20.0

func _ready():
#	get_node("Area").connect("body_entered", self, "collided")
	pass

func init():
	var forward_dir = - global_transform.basis.z.normalized()
	set_linear_velocity(throwImpulse*forward_dir)
	set_physics_process(true)

func _physics_process(delta):
	timer += delta
	if timer >= KILL_TIMER:
        queue_free()

func _on_Bullet_body_entered( body ):
	#destruir?
	#trocar por um boneco de pano?
	queue_free()
	pass # replace with function body
