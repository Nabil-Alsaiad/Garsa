extends Node2D

var vec: Vector2i

var _under_mouse: bool = false
var _unit: Node2D = null: set = set_unit, get = get_unit
func get_unit():
	return _unit
func set_unit(value):
	_unit = value
	print('my new _unit: ', value)
	if value != null:
		value.global_position = self.global_position

func set_vec(vec):
	self.vec = vec
	self.name = "land" + str(vec)

func _process(_delta):
	if !_under_mouse:
		return
	
	var released = Input.is_action_just_released('click')
	if released:
		pass
	
func can_set_unit() -> bool:
	return self._unit == null
	
func toggle_attacked(value):
	$AttackEffect.visible = value

func _on_area_2d_mouse_entered():
	_under_mouse = true

func _on_area_2d_mouse_exited():
	_under_mouse = false
	
