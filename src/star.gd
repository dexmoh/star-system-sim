class_name Star
extends CelestialObject

enum SpectralClass {
	TYPE_O, TYPE_B, TYPE_A, TYPE_F, TYPE_G, TYPE_K, TYPE_M
}

enum LuminosityClass {
	TYPE_0, TYPE_I, TYPE_II, TYPE_III, TYPE_IV, TYPE_V, TYPE_VI, TYPE_VII
}

const STAR_COLORS: Dictionary[SpectralClass, Color] = {
	SpectralClass.TYPE_O: Color.BLUE,
	SpectralClass.TYPE_B: Color.SKY_BLUE,
	SpectralClass.TYPE_A: Color.LIGHT_BLUE,
	SpectralClass.TYPE_F: Color.WHITE,
	SpectralClass.TYPE_G: Color.YELLOW,
	SpectralClass.TYPE_K: Color.ORANGE,
	SpectralClass.TYPE_M: Color.ORANGE_RED
}

const STAR_FREQUENCY_BY_SPEC_CLASS: Dictionary[SpectralClass, float] = {
	SpectralClass.TYPE_O: 1.0,
	SpectralClass.TYPE_B: 2.0,
	SpectralClass.TYPE_A: 2.0,
	SpectralClass.TYPE_F: 3.0,
	SpectralClass.TYPE_G: 9.0,
	SpectralClass.TYPE_K: 15.0,
	SpectralClass.TYPE_M: 68.0,
}

var spectral_class: SpectralClass
var luminosity_class: LuminosityClass # TODO

func _ready():
	super._ready()

	spectral_class = Util.weighted_random(STAR_FREQUENCY_BY_SPEC_CLASS, system.rng)
	color = STAR_COLORS[spectral_class]

	if object_graphic:
		object_graphic.queue_free()
		object_graphic = null
	
	object_graphic = StarGraphic.new(self)
	add_child(object_graphic)

	# Generate planets.
	var planets_to_generate: int = system.rng.randi_range(0, 10)
	for i: int in range(planets_to_generate):
		orbiters.append(
			Planet.new(system.rng.randf_range(0.1, 10.0))
		)
	
	# Make em know their place.
	orbiters.sort_custom(
		func(a: Planet, b: Planet):
			if a.orbit_radius_au < b.orbit_radius_au:
				return true
			return false
	)
	
	var index: int = 1
	for orbiter in orbiters:
		# Give em names.
		orbiter.object_name = "%s-%s" % [object_name, index]
		index += 1

		# Make em exist.
		add_child(orbiter)
