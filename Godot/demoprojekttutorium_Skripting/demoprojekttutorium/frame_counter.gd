extends Control
var frame_count: int :
	set(value):
		frame_count = value
		label.text = str(value)
	get():
		return frame_count

var run_frame_counter: bool = true

@export
var label : Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if run_frame_counter:
		frame_count += 1
		print(frame_count)
		
#func _physics_process(delta: float) -> void:
	#if run_frame_counter:
		#frame_count += 1
		#print(frame_count)
		#

	


func _on_stop_pressed() -> void:
	if run_frame_counter:
		$HBoxContainer/Stop.text = "Start"
		run_frame_counter = false
	else:
		run_frame_counter = true
		$HBoxContainer/Stop.text = "Stop"

func _on_reset_pressed() -> void:
	frame_count = 0
	
