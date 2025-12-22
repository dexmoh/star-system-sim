# Container class for tracking time.

class_name DateTime
extends Resource

const SECS_IN_MIN: int = 60
const MINS_IN_HR: int = 60
const HRS_IN_DAY: int = 24
const DAYS_IN_MNTH: int = 30
const MNTHS_IN_YR: int = 12
const DAYS_IN_YR: int = MNTHS_IN_YR * DAYS_IN_MNTH

@export var timestamp: int = 0 # Minutes.
@export var start_year: int = 2205

# Get only date string, without current time.
# Example: 2025/12/27
func get_date_str() -> String:
	var total_days: int = timestamp / (MINS_IN_HR * HRS_IN_DAY)

	var year: int = (total_days / (DAYS_IN_MNTH * MNTHS_IN_YR)) + start_year
	var month: int = (total_days % (DAYS_IN_MNTH * MNTHS_IN_YR) / DAYS_IN_MNTH) + 1
	var day: int = (total_days % DAYS_IN_MNTH) + 1

	return "%04d/%02d/%02d" % [year, month, day]

# Get only time of day string, without a date.
# Example: 15:35
func get_time_str() -> String:
	var hour: int = (timestamp / MINS_IN_HR) % HRS_IN_DAY
	var minute: int = timestamp % MINS_IN_HR

	return "%02d:%02d" % [hour, minute]

# Get current time and date as a string.
# Example: 2025/12/27 15:35
func get_date_time_str() -> String:
	return get_date_str() + " " + get_time_str()
