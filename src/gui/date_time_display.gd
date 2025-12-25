# GUI element for displaying current date and time and controlling clock speed.
# It gets automatically updated based on WorldTime.

extends Control

@onready var _dt_label: Label = %DateTimeLabel
@onready var _time_scale_label: Label = %ClockSpeedLabel
@onready var _speed_up_btn: Button = %SpeedUpBtn
@onready var _slow_down_btn: Button = %SlowDownBtn

func _ready():
	_speed_up_btn.pressed.connect(_on_speed_up_input)
	_slow_down_btn.pressed.connect(_on_slow_down_input)

	_dt_label.text = WorldTime.date_time.get_date_time_str()
	WorldTime.minute_passed.connect(_on_minute_passed)

	_time_scale_label.text = "TS-1"

func _unhandled_input(event: InputEvent):
	if event.is_action_pressed("speed_up_time"):
		_on_speed_up_input()
	elif event.is_action_pressed("slow_down_time"):
		_on_slow_down_input()

func _on_minute_passed():
	_dt_label.text = WorldTime.date_time.get_date_time_str()

func _on_speed_up_input():
	var new_speed := WorldTime.speed_up()

	match new_speed:
		WorldTime.TimeScale.TS_1:
			_time_scale_label.text = "TS-1"
		WorldTime.TimeScale.TS_2:
			_time_scale_label.text = "TS-2"
		WorldTime.TimeScale.TS_3:
			_time_scale_label.text = "TS-3"
		WorldTime.TimeScale.TS_4:
			_time_scale_label.text = "TS-4"
		WorldTime.TimeScale.TS_5:
			_time_scale_label.text = "TS-5"
	
func _on_slow_down_input():
	var new_speed := WorldTime.slow_down()

	match new_speed:
		WorldTime.TimeScale.TS_1:
			_time_scale_label.text = "TS-1"
		WorldTime.TimeScale.TS_2:
			_time_scale_label.text = "TS-2"
		WorldTime.TimeScale.TS_3:
			_time_scale_label.text = "TS-3"
		WorldTime.TimeScale.TS_4:
			_time_scale_label.text = "TS-4"
		WorldTime.TimeScale.TS_5:
			_time_scale_label.text = "TS-5"
