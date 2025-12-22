class_name Util
extends Object

enum DrawingLayers {
	ORBITS = 0,
	OBJECTS = 1
}

# The value of 1 AU in Godot units.
const AU: float = 1000.0

# Picks a random object from a dictionary based on assigned weight.
# The values don't have to add up to 100, although they should for readability.
static func weighted_random(dict: Dictionary, rng: RandomNumberGenerator = null) -> Variant:
	var total_value: float = 0.0

	for value in dict.values():
		total_value += value
	
	var rand: float
	if rng:
		rand = rng.randf() * total_value
	else:
		rand = randf() * total_value

	var sum: float = 0.0

	# Pick a random object based on weight.
	for key in dict.keys():
		sum += dict[key]
		if rand < sum:
			return key

	# This should never run.
	push_error("Weighted random function failed to pick a random value.")
	return dict.keys().pick_random()

# Calculate how many days it takes for a body to complete 1 full orbit.
static func get_orbital_period_days(radius_au: float, heavier_body_mass_sm: float) -> float:
	return sqrt(pow(radius_au, 3) / heavier_body_mass_sm) * float(DateTime.DAYS_IN_YR)
