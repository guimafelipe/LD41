extends Spatial

var myCustomer
onready var customerClass = preload("res://Scenes/Customer.tscn")

var respawnTime

signal got_free(who)

func _ready():
	var player = get_node("../../Player")
	if(player):
		var player_pos = player.get_global_transform().origin
		self.look_at(player_pos, Vector3(0, 1, 0))

func spawnCustomer(difficulty):
	if(myCustomer):
		return
	myCustomer = customerClass.instance()
	myCustomer.setDifficulty(difficulty)
	add_child(myCustomer)
	myCustomer.connect("wasFeed", self, "customerDestroyed")
	myCustomer.connect("fedWrong", self, "cstmrFedWrong")
	myCustomer.connect("lookAtMe", self, "makeLookToCustomer")
	myCustomer.connect("diedFromHunger", self, "cstmrDiedFromHunger")
	SoundManager.get_node("./DoorBell").play()

func makeLookToCustomer():
	if(get_parent()):
		get_parent().makeLookToCustomer(self.get_global_transform().origin)

func customerDestroyed():
	if(myCustomer):
		myCustomer.queue_free()
	myCustomer = null
	emit_signal("got_free", self)

func cstmrFedWrong():
	if(get_parent()):
		get_parent().lose_game(1)

func cstmrDiedFromHunger():
	if(get_parent()):
		get_parent().lose_game(2)

func _on_Timer_timeout():
#	spawnCustomer()
	pass