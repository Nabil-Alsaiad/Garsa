extends Node2D

var unit: Node2D
var _under_mouse: bool = false

func _process(_delta):
	if !_under_mouse:
		return
	
	var released = Input.is_action_just_released('click')
	if released:
		pass
	
func set_unit(unit):
	self.unit = unit
	print('my new unit: ', unit)
	unit.global_position = self.global_position

func _on_area_2d_mouse_entered():
	_under_mouse = true

func _on_area_2d_mouse_exited():
	_under_mouse = false
	
