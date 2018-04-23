extends Area

onready var foodType = preload("res://Scripts/Bullet.gd")

enum Food {PIZZA, HAMBURGUER, HOTDOG}
var myFood

var patience = 15.0

signal wasFeed
signal fedWrong
signal diedFromHunger
signal lookAtMe #will use to make player look at this direction

var min_time #= [15.0, 12.0, 10.0, 8.0]
var max_time #= [25.0, 23.0, 19.0, 15.0]

var faces = [
	preload("res://Art/Emoticons/emoticon1.png"),
	preload("res://Art/Emoticons/emoticon2.png"),
	preload("res://Art/Emoticons/emoticon3.png"),
	preload("res://Art/Emoticons/emoticon4.png"),
	preload("res://Art/Emoticons/emoticon5.png"),
	preload("res://Art/Emoticons/emoticon6.png"),
]

var was_fed = false
var fed_right = false
var is_dead = false

func _ready():
	_get_data()

func _get_data():
	min_time = GlobalData.min_time
	max_time = GlobalData.max_time

func setDifficulty(difficulty): #that is the function that actually start
	randomize()
	_get_data()
	var pat_range = max_time[difficulty] - min_time[difficulty]
	patience = min_time[difficulty] + randf()*pat_range
	$Patience.wait_time = patience
	myFood = randi()%3
	$Baloon.set_texture(myFood)
	startTimer()

func _process(delta):
	#ver quanto tempo passou e atualizar a arte para mostrar o nivel de paciencia
	var remainingTime = $Patience.time_left
	#mudar a cor do mesh instance
	if fed_right or is_dead:
		return
	updateMesh(remainingTime)
	updateFace(remainingTime)

func updateFace(remainingTime):
	if was_fed:
		return
	if(remainingTime < 5.0):
		$Face.texture = faces[3]
		return
	if(remainingTime < 10.0):
		$Face.texture = faces[2]
		return
	if(remainingTime < 15.0):
		$Face.texture = faces[1]
		return
	$Face.texture = faces[0]

func updateMesh(remaigingTime):
	$MeshInstance.updateMesh(remaigingTime)

func startTimer():
	$Patience.start()

func _on_Patience_timeout():
	if fed_right:
		return
	inanition_anim()
#	emit_signal("diedFromHunger")

func _on_Customer_body_entered( body ):
	if fed_right or is_dead:
		return
	if(body is foodType):
		was_fed = true
		$Baloon.set_texture(-1)
		var foodClass = body.foodClass
		body.queue_free()
		if(foodClass == myFood):
			fed_right_anim()
		else:
			fed_wrong_anim()


func fed_wrong_anim():
	dead_anim()

func inanition_anim():
	dead_anim()

func dead_anim():
	$MeshInstance.updateMesh(0)
	is_dead = true
	$Face.texture = faces[5]
	emit_signal("lookAtMe")
	$DeathAnimTimer.wait_time = 2
	$DeathAnimTimer.start()
	$DeathSound.play()

func fed_right_anim():
	fed_right = true
	$Patience.stop()
	$Face.texture = faces[4]
	$FedAnimTimer.wait_time = 2
	$FedAnimTimer.start()
	$FeedSound.play()

func go_away():
	emit_signal("wasFeed")
	queue_free()

func _on_FedAnimTimer_timeout():
	if not is_dead:
		go_away()

func _on_DeathAnimTimer_timeout():
	if was_fed:
		emit_signal("fedWrong")
	else:
		emit_signal("diedFromHunger")
