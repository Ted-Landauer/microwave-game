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
		$"../../Audio/dingAudio".play()
		
		print("time: " + str(time))
		print("limit: "+ str(limit))
		print("UNDER MILK LIMIT")
		$"../..".menuTriggers(true, "You've undercooked the milk. Viewers gained: " + str(temp))
		await get_tree().create_timer(3.0).timeout
		$"../..".menuTriggers(false)
		#$"../..".resetScene = true
		
		
	elif time > limit:
		temp = (3 * limit)
		#+ time
		$"../..".updateViewship(temp , "+")
		$"../../Audio/popAudio".play()
	
		print("time: " + str(time))
		print("limit: "+ str(limit))
		print("OVER MILK LIMIT")
		$"../..".swapMicrowaves("destroyed", "milk")
		$"../..".menuTriggers(true, "You cooked the milk too hard and it exploded at " + str(limit) + " seconds. Time to buy a new microwave! Viewers gained: " + str(temp))
		$"../..".brokenMicrowave = true
		
	elif time == limit:
		temp = (2 * limit) + (2 * time)
		$"../..".updateViewship(temp , "+")
		$"../../Audio/juggsecutionerAudio".play()
		
		print("time: " + str(time))
		print("limit: "+ str(limit))
		print("PERFECTLY COOKED")
		$"../..".swapMicrowaves("opened", "milk")
		$"../..".menuTriggers(true, "You exploded the milk perfectly! Viewers gained: " + str(temp))
		await get_tree().create_timer(3.0).timeout
		$"../..".menuTriggers(false)
		$"../..".swapMicrowaves("reset")
		
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
			if $"../..".extractInt($milkCount.text) > 0 and $"../..".occupied == false:
				microwaveItem = "milk"
				microwaveItemRef = $"../..".addToMicrowave("milk_jug")
				microwaveItemRef.milkLimit = randi_range(32, 37) # 32 to 37?
				$"../..".foodLimit = microwaveItemRef.milkLimit
				occupied = microwaveItemRef.occupied
				
				print("microwave item ref values:")
				print(microwaveItemRef.milkLimit)
			
