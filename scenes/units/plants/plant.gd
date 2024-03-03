extends "res://scenes/units/unit.gd"

@export var grow_time: float = 2.5

var _current_grow_time: float = 0.0
var _initial_pos: Vector2
var _was_pressed: bool

func _ready():
	super._ready()
	_initial_pos = self.global_position
	print('plant-ready')

func _process(delta):
	super._process(delta)
	
	var pressed = Input.is_action_pressed("click")
	if land == null and not pressed and world.selected_unit != self:
		print('dead 3')
		self.queue_free()
		return
	
	if land != null:
		if _current_grow_time < grow_time:
			_current_grow_time += delta
#
	if world.started:
		return
	
	if pressed and world.selected_unit == self:
		world.toggle_lands(self, false)
		self.global_position = get_global_mouse_position()
		
	var released = Input.is_action_just_released('click')
	if released and _was_pressed and world.selected_unit == self:
		var bodies = $Area2D.get_overlapping_bodies()
		if bodies.size() == 0:
			print('dead 1')
			self.queue_free()
			return
		
		for body in bodies:
			if body.name.begins_with('land') && body.can_set_unit():
				if land != null:
					land.set_unit(null)
				land = body
				_initial_pos = body.global_position
			else:
				if land != null:
					global_position = _initial_pos
				else:
					print('dead 2')
					self.queue_free()
	
	_was_pressed = pressed

func set_item(value: UnitItem):
	super.set_item(value)
	$Sprite2D.texture = value.texture
	
func is_grown() -> bool:
	return land != null and _current_grow_time <= 0

func _on_area_2d_mouse_entered():
	world.select_unit(self)

func _on_area_2d_mouse_exited():
	world.deselect_unit(self)
