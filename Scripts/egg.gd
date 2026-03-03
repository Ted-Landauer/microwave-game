extends Node2D
var clickable: bool = false
var eggLimit: int
var microwaveItem
var microwaveItemRef
var occupied: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#eggLimitSet = randi_range(5, 15)
	#print("Egg limit is: ")
	#print(eggLimitSet)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func foodLimit():
	var time = $"../..".totalSecondsToPass
	var limit = microwaveItemRef.eggLimit
	var temp
	
	if time < limit:
		temp = limit + time
		$"../..".updateViewship(temp , "+")
		$"../../Audio/dingAudio".play()
		
		print("time: " + str(time))
		print("limit: "+ str(limit))
		print("UNDER EGG LIMIT")
		$"../..".menuTriggers(true, "You've undercooked the egg. Viewers gained: " + str(temp))
		await get_tree().create_timer(3.0).timeout
		$"../..".menuTriggers(false)
		#$"../..".resetScene = true
		
		
	elif time > limit:
		temp = (2 * limit) + time
		$"../..".updateViewship(temp , "+")
		$"../../Audio/crackAudio".play()
		
		print("time: " + str(time))
		print("limit: "+ str(limit))
		print("OVER EGG LIMIT")
		$"../..".brokenMicrowave = true
		$"../..".swapMicrowaves("destroyed", "egg")
		$"../..".menuTriggers(true, "You cooked the egg too hard. Time to buy a new microwave! Viewers gained: " + str(temp))
		
	elif time == limit:
		temp = (2 * limit) + (2 * time)
		$"../..".updateViewship(temp , "+")
		$"../../Audio/eggcellentAudio".play()
		
		print("time: " + str(time))
		print("limit: "+ str(limit))
		print("PERFECTLY COOKED")
		$"../..".swapMicrowaves("opened", "egg")
		$"../..".menuTriggers(true, "You exploded the egg perfectly! Viewers gained: " + str(temp))
		await get_tree().create_timer(3.0).timeout
		$"../..".menuTriggers(false)
		$"../..".swapMicrowaves("reset")
		
	occupied = false


func _on_egg_control_mouse_entered() -> void:
	clickable = true
	print("in egg area")

func _on_egg_control_mouse_exited() -> void:
	clickable = false
	print("out of egg area")

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT and clickable == true:
			if $"../..".extractInt($eggCount.text) > 0 and $"../..".occupied == false:
				microwaveItem = "egg"
				microwaveItemRef = $"../..".addToMicrowave("egg")
				microwaveItemRef.eggLimit = randi_range(1, 5)
				occupied = microwaveItemRef.occupied
				
				print("microwave item ref values:")
				print(microwaveItemRef.eggLimit)
				
