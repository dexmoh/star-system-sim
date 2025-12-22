# The base class for stars, planets, moons and other celestial objects.

class_name CelestialObject
extends Node2D

var system: StarSystem

var primary_body: CelestialObject
var orbit_radius_au: float = -1.0 # AU
var orbital_period_days: float = 0.0
var orbit_graphic: OrbitGraphic
var object_graphic: CelestialObjectGraphic
var clockwise_orbit: bool = true

var object_name: String = "Object"
var mass_sm: float = 1.0 # SM
var color: Color = Color.WHEAT
var orbiters: Array[CelestialObject] = []

func _init(p_orbit_radius_au: float = -1.0):
	orbit_radius_au = p_orbit_radius_au

func _ready():
	# Get the current star system.
	system = null
	var node_i: Node = get_parent()
	while !system:
		if node_i is StarSystem:
			system = node_i
			break
		node_i = node_i.get_parent()

	# Graphic for drawing the object on screen.
	object_graphic = CelestialObjectGraphic.new(self)
	add_child(object_graphic)

	# If we orbit another body, create an orbit.
	if (orbit_radius_au > 0) and (get_parent() is CelestialObject):
		primary_body = get_parent() as CelestialObject
		position = Vector2.ZERO

		# Nudge the orbit center.
		# The greater the orbital radius, the more off center it can be.
		position += Vector2(
			system.rng.randf_range(-orbit_radius_au, orbit_radius_au) * 20.0,
			system.rng.randf_range(-orbit_radius_au, orbit_radius_au) * 20.0
		)

		orbit_graphic = OrbitGraphic.new(orbit_radius_au * Util.AU)
		add_child(orbit_graphic)

		object_graphic.position.y = orbit_radius_au * Util.AU

		rotation_degrees = system.rng.randf_range(0.0, 360.0)
		clockwise_orbit = true
		if system.rng.randf() < 0.3:
			clockwise_orbit = false

		# Get orbital period.
		orbital_period_days = Util.get_orbital_period_days(orbit_radius_au, primary_body.mass_sm)
	else:
		orbit_radius_au = -1.0
		primary_body = null

func _process(delta: float):
	if primary_body:
		# Test orbit rotation.
		var deg_per_hr: float = 360/(orbital_period_days * float(DateTime.HRS_IN_DAY))
		if clockwise_orbit:
			rotate(deg_to_rad(deg_per_hr * delta))
		else:
			rotate(deg_to_rad(-deg_per_hr * delta))
