extends Node2D
var clickable = false
var eggLimit
var microwaveItem
var microwaveItemRef


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	eggLimit = randi_range(5, 15)
	print("Egg limit is: ")
	print(eggLimit)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func foodLimit():
	if $"../..".totalSeconds < eggLimit:
		print("EGG LIMIT")


func _on_egg_control_mouse_entered() -> void:
	clickable = true
	print("in egg area")

func _on_egg_control_mouse_exited() -> void:
	clickable = false
	print("out of egg area")

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT and clickable == true:
			if $"../..".extractInt($eggCount.text) > 0:
				microwaveItem = "egg"
				microwaveItemRef = $"../..".addToMicrowave("egg")
				
