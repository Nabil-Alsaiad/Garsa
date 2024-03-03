extends Node2D

var _unit: Node2D
var _under_mouse: bool = false
var vec: Vector2i

func set_vec(vec):
	self.vec = vec
	self.name = "land" + str(vec)

func _process(_delta):
	if !_under_mouse:
		return
	
	var released = Input.is_action_just_released('click')
	if released:
		pass
	
func set_unit(_unit):
	self._unit = _unit
	print('my new _unit: ', _unit)
	if _unit != null:
		_unit.global_position = self.global_position
	
func can_set_unit() -> bool:
	return self._unit == null
	
func toggle_attacked(value):
	$AttackEffect.visible = value

func _on_area_2d_mouse_entered():
	_under_mouse = true

func _on_area_2d_mouse_exited():
	_under_mouse = false
	
