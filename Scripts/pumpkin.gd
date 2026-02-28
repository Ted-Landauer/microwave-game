extends Node2D
var clickable = false
var pumpkinLimit
var microwaveItem
var microwaveItemRef
var occupied: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#pumpkinLimit = randi_range(5, 15)
	#print("Pumpkin limit is: ")
	#print(pumpkinLimit)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func foodLimit():
	var time = $"../..".totalSeconds
	var limit = microwaveItemRef.pumpkinLimit
	var temp
	
	if time < limit:
		temp = limit + time
		$"../..".updateViewship(temp , "+")
		
		print("time: " + str(time))
		print("limit: "+ str(limit))
		print("UNDER PUMPKIN LIMIT")
		$"../..".menuTriggers(true, "You've undercooked the pumpkin. Viewers gained: " + str(temp))
		$"../..".resetScene = true
		
	elif time > limit:
		temp = (2 * limit) + time
		$"../..".updateViewship(temp , "+")
		
		print("time: " + str(time))
		print("limit: "+ str(limit))
		print("OVER PUMPKIN LIMIT")
		$"../..".swapMicrowaves("destroyed", "pumpkin")
		$"../..".menuTriggers(true, "You cooked the pumpkin too hard. Time to buy a new microwave! Viewers gained: " + str(temp))
		$"../..".brokenMicrowave = true
		
	elif time == limit:
		temp = (2 * limit) + (2 * time)
		$"../..".updateViewship(temp , "+")
		
		print("time: " + str(time))
		print("limit: "+ str(limit))
		print("PERFECTLY COOKED")
		$"../..".swapMicrowaves("opened", "pumpkin")
		$"../..".menuTriggers(true, "You exploded the pumpkin perfectly! Viewers gained: " + str(temp))
		
	occupied = false

func _on_pumpkin_control_mouse_entered() -> void:
	clickable = true


func _on_pumpkin_control_mouse_exited() -> void:
	clickable = false


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT and clickable == true:
			if $"../..".extractInt($pumpkinCount.text) > 0 and occupied == false:
				microwaveItem = "pumpkin"
				microwaveItemRef = $"../..".addToMicrowave("pumpkin")
				microwaveItemRef.pumpkinLimit = randi_range(15, 28)
				occupied = microwaveItemRef.occupied
				
				print("microwave item ref values:")
				print(microwaveItemRef.pumpkinLimit)
			
