extends Area

onready var foodType = preload("res://GameObjects/Bullet.gd")

enum Food {PIZZA, HAMBURGUER, HOTDOG}
var myFood

var patience = 15.0

signal wasFeed
signal fedWrong

var min_time = [15.0, 12.0, 10.0, 8.0]
var max_time = [25.0, 23.0, 19.0, 15.0]

func _ready():
	#print(self is foodType)
	min_time = GlobalData.min_time
	max_time = GlobalData.max_time
	pass

func setDifficulty(difficulty): #that is the function that actually start
	randomize()
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
	pass

func updateMesh(remaigingTime):
	$MeshInstance.updateMesh(remaigingTime)
	pass

func startTimer():
	$Patience.start()

func _on_Patience_timeout():
	print("Perdeu o jogo")
	pass # replace with function body

func _on_Customer_body_entered( body ):
	print(body is foodType)
	if(body is foodType):
#		print("Chocou com a comida")
		# checar se é a comida certa
		if(body.foodClass == myFood):
#			print("Comida certa")
			# ficar feliz
			#se retirar do restaurante
			emit_signal("wasFeed")
			body.queue_free()
			queue_free() #aqui pode ter uma animaçãozinha antes
		else:
			body.queue_free()			
#			print("Comida errada")
			emit_signal("fedWrong")
			#perdeu o jogo =/