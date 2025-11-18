extends Control

class_name HeartUI

@export_category("Hearts")
@export
var hearts : Array[TextureRect]

@export_category("Player")
@export
var player : Jack
var count: int
func _ready() -> void:
	player.heart_collected.connect(on_heart_collected)

func on_heart_collected(heart_count : int) -> void:
	if heart_count > hearts.size():
		return
	
	hearts[heart_count - 1].modulate = Color(1,1,1,1)
func on_heart_collected_overload() -> void:
	if count < hearts.size():	
		hearts[count].modulate = Color(1,1,1,1)


func _on_heart_3_pick_up() -> void:
	pass # Replace with function body.
