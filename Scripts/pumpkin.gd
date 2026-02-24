extends Node2D
var clickable = false
var pumpkinLimit
var microwaveItem
var microwaveItemRef

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pumpkinLimit = randi_range(5, 15)
	print("Pumpkin limit is: ")
	print(pumpkinLimit)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func foodLimit():
	if $"../..".totalSeconds < pumpkinLimit:
		print("PUMPKIN LIMIT")

func _on_pumpkin_control_mouse_entered() -> void:
	clickable = true


func _on_pumpkin_control_mouse_exited() -> void:
	clickable = false


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT and clickable == true:
			if $"../..".extractInt($pumpkinCount.text) > 0:
				microwaveItem = "pumpkin"
				microwaveItemRef = $"../..".addToMicrowave("pumpkin")
			
