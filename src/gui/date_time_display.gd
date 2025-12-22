# GUI element for displaying current date and time.
# It gets automatically updated based on WorldTime.

extends Label

func _ready():
	text = WorldTime.date_time.get_date_time_str()
	WorldTime.minute_passed.connect(_on_minute_passed)

func _on_minute_passed():
	text = WorldTime.date_time.get_date_time_str()
