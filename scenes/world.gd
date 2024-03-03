extends Node2D

@export var grid_size: Vector2i = Vector2i.ONE * 3
@export var _land_size: float = 130.0
@export var _land_scene: PackedScene = preload("res://scenes/lands/land.tscn")
@export var _plant_scene: PackedScene = preload("res://scenes/units/plants/plant.tscn")
@export var inventory: Inventory

var lands = {}
var timer = 0.0
var started: bool = false
var selected_unit: Node2D

func _ready():
	if grid_size.x % 2 == 0 or grid_size.y % 2 == 0:
		print("Keep grid size of odd numbers")
	
	var grid_start = -((grid_size / 2) * (_land_size))
	for y in range(grid_size.y):
		for x in range(grid_size.x):
			var land = _land_scene.instantiate()
			var vec = Vector2i(x, y)
			$Lands.add_child(land)
			land.set_vec(vec)
			land.position = grid_start + (vec * _land_size)
			lands[vec] = land
			print("land_pos: ", land, str(land.global_position))
	
	print("lands: ", lands)
	
	for enemy in $Enemies.get_children():
		enemy.managed_ready()

func _process(delta):
	if not started:
		return
	
	timer += delta
	var minutes = int(timer) / 60
	var seconds = int(timer) % 60
	$timer.text = "%02d:%02d" % [minutes, seconds]

func restart_game():
	timer = 0
	$timer.text = "00:00"
	
	for child in $Plants.get_children():
		child.queue_free()
	
func select_unit(unit: Node2D) -> void:
	var pressed = Input.is_action_pressed("click")
	if pressed and selected_unit != null:
		return
	
	if selected_unit != null and selected_unit != unit:
		deselect_unit(selected_unit)
	
	selected_unit = unit
	if not pressed:
		toggle_lands(unit, true)
	
func deselect_unit(unit: Node2D) -> void:
	if selected_unit == unit:
		toggle_lands(unit, false)
		selected_unit = null

func toggle_lands(unit: Node2D, value: bool) -> void:
	if unit.land != null:
		var lands = unit.get_attackable_lands()
		for land in lands:
			land.toggle_attacked(value)

func _on_button_pressed():
	started = not started
		
	if started:
		$Button.text = "إيقاف"
	else:
		$Button.text = "بدء"
		restart_game()
