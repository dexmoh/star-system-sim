# Class for containing the entire star system
# together with stars, planets, moons and other bodies.

class_name StarSystem
extends Node2D

var system_name: String = "SYSTEM"
var rng: RandomNumberGenerator
var star: Star

func _init():
	system_name = Sim.name_base.get_random_system_name()

	rng = RandomNumberGenerator.new()
	rng.seed = system_name.hash()

	position = Vector2.ZERO

func _ready():
	# Create a single star system.
	star = Star.new()
	star.object_name = system_name
	add_child(star)
