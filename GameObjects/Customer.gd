extends Area

onready var foodType = preload("res://GameObjects/Bullet.gd")

export var patience = 15.0
enum Food {PIZZA, HAMBURGUER, HOTDOG}
var myFood

signal wasFeed
signal fedWrong

func _ready():
	$Patience.wait_time = patience
	randomize()
	myFood = randi()%3
	
	startTimer()
	#print(self is foodType)
	pass

#func init(_patience, _foodType):
#	patience = _patience 
#	myFood = _foodType #TODO: gerar aleatoriamente uma comida
#	pass

func _process(delta):
	#ver quanto tempo passou e atualizar a arte para mostrar o nivel de paciencia
	var remainingTime = $Patience.time_left
	#mudar a cor do mesh instance
	updateMesh(remainingTime)
	pass

func updateMesh(remaigingTime):
	pass

func startTimer():
	$Patience.start()

func _on_Patience_timeout():
	print("Perdeu o jogo")
	pass # replace with function body

func _on_Customer_body_entered( body ):
	print("oi")
	print(body is foodType)
	if(body is foodType):
		print("Chocou com a comida")
		# checar se é a comida certa
		if(body.foodClass == myFood):
			print("Comida certa")
			# ficar feliz
			#se retirar do restaurante
			emit_signal("wasFeed")
			body.queue_free()
			queue_free() #aqui pode ter uma animaçãozinha antes
		else:
			body.queue_free()			
			print("Comida errada")
			emit_signal("fedWrong")
			#perdeu o jogo =/