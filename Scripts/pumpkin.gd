extends Node2D
var clickable = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pumpkin_control_mouse_entered() -> void:
	clickable = true


func _on_pumpkin_control_mouse_exited() -> void:
	clickable = false


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT and clickable == true:
			$"../..".addToMicrowave("pumpkin")
