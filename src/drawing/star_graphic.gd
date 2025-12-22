# Class for drawing stars.

class_name StarGraphic
extends CelestialObjectGraphic

func _draw():
	draw_circle(position, size, cel_obj.color)

	# Draw the spikey thingies.
	var buffer: float = 5.0

	draw_colored_polygon(
		[Vector2(size / 2.0, -size - buffer), Vector2(-size / 2.0, -size - buffer), Vector2(0.0, -size * 1.5 - buffer)],
		cel_obj.color
	)
	draw_colored_polygon(
		[Vector2(size + buffer, -size / 2.0), Vector2(size + buffer, size / 2.0), Vector2(size * 1.5 + buffer, 0.0)],
		cel_obj.color
	)
	draw_colored_polygon(
		[Vector2(size / 2.0, size + buffer), Vector2(-size / 2.0, size + buffer), Vector2(0.0, size * 1.5 + buffer)],
		cel_obj.color
	)
	draw_colored_polygon(
		[Vector2(-size - buffer, size / 2.0), Vector2(-size - buffer, -size / 2.0), Vector2(-size * 1.5 - buffer, 0.0)],
		cel_obj.color
	)

	# Draw the name of the star under it.
	if _show_name_label:
		var string_size: Vector2 = FONT.get_string_size(
			cel_obj.object_name,
			HORIZONTAL_ALIGNMENT_CENTER,
			-1,
			FONT_SIZE
		)

		var string_pos = Vector2(
			position.x - string_size.x * 0.5,
			position.y + size + string_size.y + 20.0
		)

		draw_string(
			FONT,
			string_pos,
			cel_obj.object_name,
			HORIZONTAL_ALIGNMENT_LEFT,
			-1,
			FONT_SIZE
		)
