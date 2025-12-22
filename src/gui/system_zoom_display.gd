extends Label

func _ready():
	SystemCamera.zoom_changed.connect(_on_zoom_changed)

func _on_zoom_changed(new_zoom: float):
	text = "x %.2f" % new_zoom
