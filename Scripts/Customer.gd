extends Area

onready var foodType = preload("res://Scripts/Bullet.gd")

enum Food {PIZZA, HAMBURGUER, HOTDOG}
var myFood

var patience = 15.0

signal wasFeed
signal fedWrong
signal diedFromHunger

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

func _ready():
	#print(self is foodType)
	_get_data()
	pass

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
	startTimer()
	pass

func _process(delta):
	#ver quanto tempo passou e atualizar a arte para mostrar o nivel de paciencia
	var remainingTime = $Patience.time_left
	#mudar a cor do mesh instance
	updateMesh(remainingTime)
	updateFace(remainingTime)
	pass

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
	$Face.texture = faces[0]

func updateMesh(remaigingTime):
	$MeshInstance.updateMesh(remaigingTime)
	pass

func startTimer():
	$Patience.start()

func _on_Patience_timeout():
	print("Perdeu o jogo")
	emit_signal("diedFromHunger")
	pass # replace with function body

func _on_Customer_body_entered( body ):
	print(body is foodType)
	if(body is foodType):
		was_fed = true
		# checar se é a comida certa
		if(body.foodClass == myFood):
#			print("Comida certa")
			# ficar feliz
			#se retirar do restaurante
			emit_signal("wasFeed")
			$Face.texture = faces[4]
			body.queue_free()
			queue_free() #aqui pode ter uma animaçãozinha antes
		else:
			body.queue_free()			
#			print("Comida errada")
			$Face.texture = faces[5]
			emit_signal("fedWrong")
			#perdeu o jogo =/