extends "res://scenes/units/unit.gd"

@export var land_pos: Vector2i = Vector2i.ZERO

func managed_ready():
	var row = $"../..".lands[land_pos.y]
	print("row: ", row)
	print("row[land_pos.x]: ", row[land_pos.x])
	self.land = row[land_pos.x]

func _process(delta):
	pass
