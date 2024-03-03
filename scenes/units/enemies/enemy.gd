extends "res://scenes/units/unit.gd"

@export var land_pos: Vector2i = Vector2i.ZERO

var _under_mouse: bool = false
	
func managed_ready():
	var lands = $"../..".lands
	self.land = lands[Vector2i(land_pos.x, land_pos.y)]

func _process(delta):
	super._process(delta)
	if land != null:
		var lands = get_attackable_lands()
		for land in lands:
			land.toggle_attacked(_under_mouse)

func _on_area_2d_mouse_entered():
	_under_mouse = true

func _on_area_2d_mouse_exited():
	_under_mouse = false
