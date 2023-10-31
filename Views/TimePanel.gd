extends Panel
signal timeIsUp()

var time: float = 45.0
var minutes:  int = 0
var seconds: int = 45
var isTimeUp: bool = false

# Called when the node enters the scene tree for the first time.
func reset():
	isTimeUp = false
	time  = 45.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	time -= delta
	seconds = fmod(time, 60)
	minutes = fmod(time, 3600) / 60
	$Minutes.text = "%2d:" % minutes
	$Seconds.text = "%02d" % seconds
	
	if (time <= 0.0 && not isTimeUp):
		isTimeUp = true
		timeIsUp.emit()


func _on_score_manager_reset_game():
	reset()
