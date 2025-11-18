extends Node3D

signal pick_up
@export
var heart_area : Area3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	heart_area.body_entered.connect(body_entered)

func body_entered(body : Node3D) -> void:
	if body is Jack:
		pick_up.emit
		#body.on_heart_collected()
		queue_free()
