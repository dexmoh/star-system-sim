extends Node

signal minute_passed()
signal hour_passed()
signal day_passed()

enum TimeScale {
	TS_1, TS_2, TS_3, TS_4, TS_5
}

const CLOCK_SPEEDS: Dictionary[TimeScale, float] = {
	TimeScale.TS_1: 60.0, # Real time.
	TimeScale.TS_2: 1.0,
	TimeScale.TS_3: 0.5,
	TimeScale.TS_4: 0.2,
	TimeScale.TS_5: 0.05
}

var date_time: DateTime
var current_time_scale: TimeScale = TimeScale.TS_1

var _timer: Timer

func _init():
	date_time = DateTime.new()
	date_time.timestamp += 7 * DateTime.MINS_IN_HR # Game starts at 7 AM.
	date_time.timestamp += 11 * DateTime.MINS_IN_HR * DateTime.HRS_IN_DAY # On the 11th day of the month.

func _ready():
	_timer = Timer.new()
	_timer.wait_time = CLOCK_SPEEDS[current_time_scale]
	_timer.one_shot = false
	_timer.autostart = true
	_timer.paused = false

	_timer.timeout.connect(_on_timer_timeout)
	add_child(_timer)

func pause():
	_timer.paused = true

func unpause():
	_timer.paused = false

func is_paused() -> bool:
	return _timer.paused

func speed_up() -> TimeScale:
	if current_time_scale == TimeScale.TS_5:
		return TimeScale.TS_5
	
	@warning_ignore("int_as_enum_without_cast")
	current_time_scale += 1
	_timer.wait_time = CLOCK_SPEEDS[current_time_scale]
	_timer.start()

	return current_time_scale

func slow_down() -> TimeScale:
	if current_time_scale == TimeScale.TS_1:
		return TimeScale.TS_1
	
	@warning_ignore("int_as_enum_without_cast")
	current_time_scale -= 1
	_timer.wait_time = CLOCK_SPEEDS[current_time_scale]
	_timer.start()

	return current_time_scale

func _on_timer_timeout():
	# Tick!
	date_time.timestamp += 1
	minute_passed.emit()

	if date_time.timestamp % date_time.MINS_IN_HR == 0:
		hour_passed.emit()
	
	if date_time.timestamp % (date_time.MINS_IN_HR * date_time.HRS_IN_DAY) == 0:
		day_passed.emit()
