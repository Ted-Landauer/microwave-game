extends Node2D
var clickable = false
var milkLimit
var microwaveItem
var microwaveItemRef
var occupied: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#milkLimit = randi_range(5, 15)
	#print("Milk limit is: ")
	#print(milkLimit)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func foodLimit():
	var time = $"../..".totalSeconds
	var limit = microwaveItemRef.milkLimit
	var temp
	
	if time < limit:
		temp = limit + time
		$"../..".updateViewship(temp , "+")
		
		print("time: " + str(time))
		print("limit: "+ str(limit))
		print("UNDER MILK LIMIT")
	elif time > limit:
		temp = (2 * limit) + time
		$"../..".updateViewship(temp , "+")
	
		print("time: " + str(time))
		print("limit: "+ str(limit))
		print("OVER MILK LIMIT")
		$"../..".swapMicrowaves("destroyed", "milk")
		
	elif time == limit:
		temp = (2 * limit) + (2 * time)
		$"../..".updateViewship(temp , "+")
		
		print("time: " + str(time))
		print("limit: "+ str(limit))
		print("PERFECTLY COOKED")
		$"../..".swapMicrowaves("opened", "milk")
		
	occupied = false

func _on_milk_jug_control_mouse_entered():
	clickable = true
	print("in milk area")

func _on_milk_jug_control_mouse_exited():
	clickable = false
	print("out of milk area")

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT and clickable == true:
			if $"../..".extractInt($milkCount.text) > 0 and occupied == false:
				microwaveItem = "milk"
				microwaveItemRef = $"../..".addToMicrowave("milk_jug")
				microwaveItemRef.milkLimit = randi_range(10, 18)
				occupied = microwaveItemRef.occupied
				
				print("microwave item ref values:")
				print(microwaveItemRef.milkLimit)
			
