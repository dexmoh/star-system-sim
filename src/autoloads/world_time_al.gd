extends Node

signal minute_passed()
# signal hour_passed()
# signal day_passed()

var date_time: DateTime

var _timer: Timer
var _tick_speed: float = 1.0 # Seconds per tick.

func _init():
	date_time = DateTime.new()
	date_time.timestamp += 7 * DateTime.MINS_IN_HR # Game starts at 7 AM.
	date_time.timestamp += 11 * DateTime.MINS_IN_HR * DateTime.HRS_IN_DAY # On the 11th day of the month.

func _ready():
	_timer = Timer.new()
	_timer.wait_time = _tick_speed
	_timer.one_shot = false
	_timer.autostart = true
	_timer.paused = false # TODO: Change later.

	_timer.timeout.connect(_on_timer_timeout)
	add_child(_timer)

func pause():
	_timer.paused = true

func unpause():
	_timer.paused = false

func is_paused() -> bool:
	return _timer.paused

# Tick!
func _on_timer_timeout():
	date_time.timestamp += 1
	minute_passed.emit()
