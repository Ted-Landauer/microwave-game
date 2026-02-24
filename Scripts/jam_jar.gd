extends Node2D
var clickable = false
var jamLimit
var microwaveItem
var microwaveItemRef

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	jamLimit = randi_range(5, 15)
	print("Jam limit is: ")
	print(jamLimit)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func foodLimit():
	if $"../..".totalSeconds < jamLimit:
		print("JAM LIMIT")

func _on_jam_jar_control_mouse_entered() -> void:
	clickable = true

func _on_jam_jar_control_mouse_exited() -> void:
	clickable = false

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT and clickable == true:
			if $"../..".extractInt($jamCount.text) > 0:
				microwaveItem = "jam"
				microwaveItemRef = $"../..".addToMicrowave("jam_jar")
			
