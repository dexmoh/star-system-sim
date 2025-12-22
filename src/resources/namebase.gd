# Resource for storing lists of names for stars.

class_name NameBase
extends Resource

@export var system_names: Array[String] = []

func get_random_system_name() -> String:
	return system_names.pick_random()
