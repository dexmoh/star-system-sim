extends Node

const NAME_BASE_PATH: String = "res://data/names.tres"

var name_base: NameBase

func _init():
	# Load names lists.
	name_base = preload(NAME_BASE_PATH)
