# Camera used to display a map of the star system.

extends Camera2D

signal zoom_changed(new_zoom: float)
signal zoom_level_changed(new_zoom_level: ZoomLevel)

enum ZoomLevel {
	LEVEL_1 = 1, # < 0.5
	LEVEL_2,     # < 1.0
	LEVEL_3,     # < 4.0
	LEVEL_4      # > 4.0
}

const MIN_ZOOM: float = 0.05
const MAX_ZOOM: float = 10.0
const MOVEMENT_SMOOTHING: float = 8.0

@export var focus: Node2D
@export var zoom_speed: float = 10.0

var is_panning: bool = false
var zoom_level: ZoomLevel = ZoomLevel.LEVEL_2

var _zoom_target: Vector2 = zoom
var _pan_start_mouse_pos: Vector2 = Vector2.ZERO
var _pan_start_cam_pos: Vector2 = Vector2.ZERO

func _process(delta: float):
	# Move camera towards focus.
	if !is_panning and focus:
		position = position.slerp(focus.global_position, MOVEMENT_SMOOTHING * delta)
	
	# Zoom camera.
	if Input.is_action_just_pressed("zoom_in"):
		_zoom_target *= 1.1
	elif Input.is_action_just_pressed("zoom_out"):
		_zoom_target *= 0.9
	
	var old_zoom := zoom
	_zoom_target = _zoom_target.clampf(MIN_ZOOM, MAX_ZOOM)
	zoom = zoom.slerp(_zoom_target, zoom_speed * delta)

	if !zoom.is_equal_approx(old_zoom):
		zoom_changed.emit(zoom.x)

		match zoom_level:
			ZoomLevel.LEVEL_1:
				if zoom.x > 0.5:
					zoom_level = ZoomLevel.LEVEL_2
					zoom_level_changed.emit(zoom_level)
			ZoomLevel.LEVEL_2:
				if zoom.x < 0.5:
					zoom_level = ZoomLevel.LEVEL_1
					zoom_level_changed.emit(zoom_level)
				elif zoom.x > 1.0:
					zoom_level = ZoomLevel.LEVEL_3
					zoom_level_changed.emit(zoom_level)
			ZoomLevel.LEVEL_3:
				if zoom.x < 1.0:
					zoom_level = ZoomLevel.LEVEL_2
					zoom_level_changed.emit(zoom_level)
				elif zoom.x > 4.0:
					zoom_level = ZoomLevel.LEVEL_4
					zoom_level_changed.emit(zoom_level)
			ZoomLevel.LEVEL_4:
				if zoom.x < 4.0:
					zoom_level = ZoomLevel.LEVEL_3
					zoom_level_changed.emit(zoom_level)
			
	
	# Pan camera.
	if !is_panning and Input.is_action_just_pressed("camera_pan"):
		is_panning = true
		_pan_start_cam_pos = position
		_pan_start_mouse_pos = get_viewport().get_mouse_position()
	elif is_panning and Input.is_action_just_released("camera_pan"):
		is_panning = false
	elif is_panning:
		var move_vec := get_viewport().get_mouse_position() - _pan_start_mouse_pos
		position = _pan_start_cam_pos - move_vec * (1 / zoom.x)
