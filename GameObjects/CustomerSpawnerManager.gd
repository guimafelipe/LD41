extends Spatial

var difficulty = 0
const max_difficulty = 3
const cstmr_spwnr_class = preload("res://GameObjects/CustomerSpawner.gd")

# isso aqui deveria ir nos customers.
# var min_time = [15.0, 12.0, 10.0, 8.0]
# var max_time = [25.0, 23.0, 19.0, 15.0]
var spawn_time = [13.0, 10.0, 7.0, 4.0]

var spawners_free = [] # array of customer spawners
var spawners_used = []

func _ready():
	var possible_spawners = get_children()
	for spawner in possible_spawners:
		if spawner is cstmr_spwnr_class: 
			spawners_free.append(spawner)
	for spawner in spawners_free:
		spawner.connect("got_free", self, "free_spawner")
	reset_timer()
	pass

func _process(delta):
	pass

func reset_timer():
	randomize()
	var uncertainty = randf()*2 - 1
	assert(difficulty >= 0 and difficulty < spawn_time.size())
	$SpawnTimer.wait_time = spawn_time[difficulty] + uncertainty
	$SpawnTimer.start()
	print("resetei o timer ", $SpawnTimer.wait_time)

func increase_difficulty():
	if(difficulty == max_difficulty):
		return
	difficulty+=1

func free_spawner(who):
	spawners_used.erase(who)
	spawners_free.append(who)
	pass

func spawn_customer():
	randomize()
	var i = randi()%spawners_free.size()
	var to_spawn = spawners_free[i]
	to_spawn.spawnCustomer(difficulty)
	spawners_free.erase(to_spawn)
	spawners_used.append(to_spawn)

func _on_SpawnTimer_timeout():
	#select a free spanwer to spawn a customer
	spawn_customer()
	#move it to not free spawner array
	#reset timer
	reset_timer()
	pass # replace with function body
