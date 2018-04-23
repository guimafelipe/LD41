extends Sprite3D

enum {PIZZA, HAMBURGUER, HOTDOG}

var textures = [
	preload("res://Art/FoodIcons/PizzaSprite3D.png"),
	preload("res://Art/FoodIcons/BurguerSprite3D.png"),
	preload("res://Art/FoodIcons/HotdogSprite3D.png")
]

func set_texture(food):
	match food:
		PIZZA:
			texture = textures[0]
		HAMBURGUER:
			texture = textures[1]
		HOTDOG:
			texture = textures[2]
		_:
			texture = null