class_name OrbitGraphic
extends Node2D

var radius: float
var color: Color

var _line_width: float = 6.0
var _current_zoom_level: SystemCamera.ZoomLevel = SystemCamera.ZoomLevel.LEVEL_2

func _init(p_radius: float, p_color: Color = Color.WHITE):
	radius = p_radius
	color = p_color
	z_index = Util.DrawingLayers.ORBITS

func _ready():
	SystemCamera.zoom_level_changed.connect(_on_zoom_level_changed)

func _draw():
	draw_circle(position, radius, color, false, _line_width)

func _on_zoom_level_changed(new_zoom_level: SystemCamera.ZoomLevel):
	if _current_zoom_level == new_zoom_level:
		return
	
	_current_zoom_level = new_zoom_level

	match new_zoom_level:
		SystemCamera.ZoomLevel.LEVEL_1: _line_width = 8.0
		SystemCamera.ZoomLevel.LEVEL_2: _line_width = 4.0
		SystemCamera.ZoomLevel.LEVEL_3: _line_width = 1.5
		SystemCamera.ZoomLevel.LEVEL_4: _line_width = 0.5
	
	queue_redraw()
