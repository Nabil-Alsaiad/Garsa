extends "res://scenes/units/unit.gd"

@export var grow_time: float = 2.5

var _under_mouse: bool = false
var held: bool = false
var _current_grow_time: float = 0.0
var _initial_pos: Vector2

func _ready():
	super._ready()
	_initial_pos = self.global_position
	print('plant-ready')

func _process(delta):
	super._process(delta)
	if land == null and not held:
		self.queue_free()
		return
	
	if land != null:
		if _current_grow_time < grow_time:
			_current_grow_time += delta

	if land != null:
		var lands = get_attackable_lands()
		for land in lands:
				land.toggle_attacked(not held and _under_mouse)

	if not _under_mouse or world.started:
		return
	
	var mouse_pos = get_global_mouse_position()
	var pressed = Input.is_action_pressed('click')
	if pressed:
		self.global_position = mouse_pos
		if not self.held:
			self.held = true
		
	var released = Input.is_action_just_released('click')
	if released and held:
		var bodies = $Area2D.get_overlapping_bodies()
		if bodies.size() == 0:
			self.queue_free()
			return
		
		for body in bodies:
			if body.name.begins_with('land') && body.can_set_unit():
				self.held = false
				if land != null:
					land.set_unit(null)
				land = body
				_initial_pos = body.global_position
			else:
				if land != null:
					global_position = _initial_pos
				else:
					self.queue_free()

func set_item(value: UnitItem):
	super.set_item(value)
	$Sprite2D.texture = value.texture
	
func is_grown() -> bool:
	return land != null and _current_grow_time <= 0

func _on_area_2d_mouse_entered():
	_under_mouse = true

func _on_area_2d_mouse_exited():
	_under_mouse = false
