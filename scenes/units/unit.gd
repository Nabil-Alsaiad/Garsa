extends Node2D

var land: StaticBody2D = null: set = _set_land
func _set_land(value: StaticBody2D):
	land = value
	if land != null:
		land.set_unit(self)
