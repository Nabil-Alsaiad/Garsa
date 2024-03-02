extends Node2D

@export var _land_size: float = 130.0
@export var _grid_size: Vector2i = Vector2i.ONE * 3
@export var _land_scene: PackedScene = preload("res://scenes/lands/land.tscn")
@export var _plant_scene: PackedScene = preload("res://scenes/units/plants/plant.tscn")

var lands = []

func _ready():
	var grid_start = -((_grid_size / 2) * (_land_size))
	for y in range(_grid_size.y):
		var row = []
		for x in range(_grid_size.x):
			var land = _land_scene.instantiate()
			land.position = grid_start + Vector2(x * _land_size, y * _land_size)
			print("(", x, " ", y,")")
			$Lands.add_child(land)
			land.name = "land" + "(" + str(x) + "," + str(y) + ")"
			row.append(land)
		lands.append(row)
	
	print("lands: ", lands)
	
	for enemy in $Enemies.get_children():
		enemy.managed_ready()
	
	var plant = _plant_scene.instantiate()
	$Plants.add_child.call_deferred(plant)
