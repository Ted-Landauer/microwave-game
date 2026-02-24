extends Node2D
var clickable = false
var potatoLimit
var microwaveItem
var microwaveItemRef

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	potatoLimit = randi_range(5, 15)
	print("Potato limit is: ")
	print(potatoLimit)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	

func foodLimit():
	if $"../..".totalSeconds < potatoLimit:
		print("POTATO LIMIT")

func _on_potato_control_mouse_entered() -> void:
	clickable = true
	
	


func _on_potato_control_mouse_exited() -> void:
	clickable = false


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT and clickable == true:
			if $"../..".extractInt($potatoCount.text) > 0:
				microwaveItem = "potato"
				microwaveItemRef = $"../..".addToMicrowave("potato")
			
