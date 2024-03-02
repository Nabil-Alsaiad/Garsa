extends "res://scenes/units/unit.gd"

@export var grow_time: float = 2.5
@export var grow_speed: float = 1.0

var _under_mouse: bool = false
var held: bool = false
var _current_grow_time: float = 0.0
var _initial_pos: Vector2

func _ready():
	_current_grow_time = grow_time
	_initial_pos = self.global_position

func _process(delta):
	#if land != null:
		#if _current_grow_time > 0:
			#_current_grow_time -= self.grow_speed * delta
		#return
	
	if not _under_mouse:
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
		for body in bodies:
			if body.name.begins_with('land') && body.can_set_unit():
				self.held = false
				if land != null:
					land.set_unit(null)
				land = body
				_initial_pos = body.global_position
			else:
				global_position = _initial_pos
				
func is_grown() -> bool:
	return land != null and _current_grow_time <= 0

func _on_area_2d_mouse_entered():
	_under_mouse = true

func _on_area_2d_mouse_exited():
	_under_mouse = false
