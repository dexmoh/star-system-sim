# Base class for drawing celestial objects.

class_name CelestialObjectGraphic
extends Node2D

const FONT: Font = preload("res://assets/fonts/source_code_pro_extra_light.ttf")
const FONT_SIZE: int = 50

var cel_obj: CelestialObject
var size: float = 50.0

var _show_name_label: bool = false

func _init(p_cel_obj: CelestialObject):
	cel_obj = p_cel_obj
	z_index = Util.DrawingLayers.OBJECTS

func _ready():
	SystemCamera.zoom_changed.connect(_on_zoom_changed)
	SystemCamera.zoom_level_changed.connect(_on_zoom_level_changed)

func _draw():
	if !cel_obj:
		return

	draw_circle(Vector2.ZERO, size, cel_obj.color)

	# Draw the name.
	if _show_name_label:
		var string_size: Vector2 = FONT.get_string_size(
			cel_obj.object_name,
			HORIZONTAL_ALIGNMENT_CENTER,
			-1,
			FONT_SIZE
		)

		var string_pos = Vector2(
			position.x - string_size.x * 0.5,
			size + string_size.y
		)

		draw_string(
			FONT,
			string_pos,
			cel_obj.object_name,
			HORIZONTAL_ALIGNMENT_LEFT,
			-1,
			FONT_SIZE
		)

func _on_zoom_changed(new_zoom: float):
	if new_zoom <= 1.0:
		return
	
	scale = Vector2.ONE / new_zoom

func _on_zoom_level_changed(new_zoom_level: SystemCamera.ZoomLevel):
	if _show_name_label and new_zoom_level < SystemCamera.ZoomLevel.LEVEL_2:
		_show_name_label = false
		queue_redraw()
	elif !_show_name_label and new_zoom_level >= SystemCamera.ZoomLevel.LEVEL_2:
		_show_name_label = true
		queue_redraw()
