extends Node2D
var clickable = false
var milkLimit
var microwaveItem
var microwaveItemRef


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	milkLimit = randi_range(5, 15)
	print("Milk limit is: ")
	print(milkLimit)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func foodLimit():
	if $"../..".totalSeconds < milkLimit:
		print("MILK LIMIT")

func _on_milk_jug_control_mouse_entered():
	clickable = true
	print("in milk area")

func _on_milk_jug_control_mouse_exited():
	clickable = false
	print("out of milk area")

	
	

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT and clickable == true:
			if $"../..".extractInt($milkCount.text) > 0:
				microwaveItem = "milk"
				microwaveItemRef = $"../..".addToMicrowave("milk_jug")
			
