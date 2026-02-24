extends Node2D
var clickable = false
var potatoLimit
var microwaveItem
var microwaveItemRef
var occupied: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#potatoLimit = randi_range(5, 15)
	#print("Potato limit is: ")
	#print(potatoLimit)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	

func foodLimit():
	var time = $"../..".totalSeconds
	var limit = microwaveItemRef.potatoLimit
	var temp
	
	if time < limit:
		temp = limit + time
		$"../..".updateViewship(temp , "+")
		
		print("time: " + str(time))
		print("limit: "+ str(limit))
		print("UNDER POTATO LIMIT")
	elif time > limit:
		temp = (2 * limit) + time
		$"../..".updateViewship(temp , "+")
		
		print("time: " + str(time))
		print("limit: "+ str(limit))
		print("OVER POTATO LIMIT")
	elif time == limit:
		temp = (2 * limit) + (2 * time)
		$"../..".updateViewship(temp , "+")
		
		print("time: " + str(time))
		print("limit: "+ str(limit))
		print("PERFECTLY COOKED")
		
	occupied = false

func _on_potato_control_mouse_entered() -> void:
	clickable = true
	
	


func _on_potato_control_mouse_exited() -> void:
	clickable = false


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT and clickable == true:
			if $"../..".extractInt($potatoCount.text) > 0 and occupied == false:
				microwaveItem = "potato"
				microwaveItemRef = $"../..".addToMicrowave("potato")
				microwaveItemRef.potatoLimit = randi_range(5, 12)
				occupied = microwaveItemRef.occupied
				
				print("microwave item ref values:")
				print(microwaveItemRef.potatoLimit)
			
