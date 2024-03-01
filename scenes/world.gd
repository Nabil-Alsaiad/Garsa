extends Node2D

@export var offset: float = 65.0
@export var _grid_size: Vector2i = Vector2i.ONE
@export var _land_scene: PackedScene = preload("res://scenes/lands/land.tscn")
@export var _plant_scene: PackedScene = preload("res://scenes/units/plants/plant.tscn")

func _ready():
	var land1 = _land_scene.instantiate()
	land1.position = Vector2(offset, offset)
	#land1.name = 'Land'
	$Lands.add_child.call_deferred(land1)
	
	var land2 = _land_scene.instantiate()
	land2.position = Vector2(-offset, offset)
	#land2.name = 'Land'
	$Lands.add_child.call_deferred(land2)
	
	var land3 = _land_scene.instantiate()
	land3.position = Vector2(offset, -offset)
	#land3.name = 'Land'
	$Lands.add_child.call_deferred(land3)
	
	var land4 = _land_scene.instantiate()
	land4.position = Vector2(-offset, -offset)
	#land4.name = 'Land'
	$Lands.add_child.call_deferred(land4)
	
	var plant = _plant_scene.instantiate()
	$Plants.add_child.call_deferred(plant)
	
