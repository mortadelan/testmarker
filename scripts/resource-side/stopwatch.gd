class_name Stopwatch
extends Timer

var count : int
var pretty_count : String

func _ready():
	wait_time = 9999

func _process(_delta: float):
	count = int(abs(time_left - wait_time))
	pretty_count = str(count / 60).pad_zeros(2) + ":" + str(count % 60).pad_zeros(2)
