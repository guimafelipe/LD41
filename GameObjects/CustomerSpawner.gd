extends Spatial

var myCustomer
onready var customerClass = preload("res://GameObjects/Customer.tscn")

var respawnTime
export var maxRespawnTime = 10.0

func _ready():
	$Timer.wait_time = maxRespawnTime
	$Timer.start()
	pass

func spawnCustomer():
	if(myCustomer):
		return
	myCustomer = customerClass.instance()
	add_child(myCustomer)
	myCustomer.connect("wasFeed", self, "customerDestroyed")

func customerDestroyed():
	#faz alguma coisa com o customer?
	if(myCustomer):
		myCustomer.queue_free()
	myCustomer = null
	$Timer.start()


func _on_Timer_timeout():
	spawnCustomer()
