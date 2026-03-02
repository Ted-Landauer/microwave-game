extends Node2D
var clickable = false
var jamLimit
var microwaveItem
var microwaveItemRef
var occupied: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#jamLimit = randi_range(5, 15)
	#print("Jam limit is: ")
	#print(jamLimit)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func foodLimit():
	var time = $"../..".totalSeconds
	var limit = microwaveItemRef.jamLimit
	var temp
	
	if time < limit:
		temp = limit + time
		$"../..".updateViewship(temp , "+")
		
		print("time: " + str(time))
		print("limit: "+ str(limit))
		print("UNDER JAM LIMIT")
		$"../..".menuTriggers(true, "You've undercooked the jam. Viewers gained: " + str(temp))
		await get_tree().create_timer(3.0).timeout
		$"../..".menuTriggers(false)
		#$"../..".resetScene = true
		
	elif time > limit:
		temp = (2 * limit) + time
		$"../..".updateViewship(temp , "+")
		
		print("time: " + str(time))
		print("limit: "+ str(limit))
		print("OVER JAM LIMIT")
		$"../..".swapMicrowaves("destroyed", "jam")
		$"../..".menuTriggers(true, "You cooked the jam too hard. Time to buy a new microwave! Viewers gained: " + str(temp))
		$"../..".brokenMicrowave = true
		
	elif time == limit:
		temp = (2 * limit) + (2 * time)
		$"../..".updateViewship(temp , "+")
	
		print("time: " + str(time))
		print("limit: "+ str(limit))
		print("PERFECTLY COOKED")
		$"../..".swapMicrowaves("opened", "jam")
		$"../..".menuTriggers(true, "You exploded the jam perfectly! Viewers gained: " + str(temp))
		await get_tree().create_timer(3.0).timeout
		$"../..".menuTriggers(false)
		$"../..".swapMicrowaves("reset")
		
	occupied = false

func _on_jam_jar_control_mouse_entered() -> void:
	clickable = true

func _on_jam_jar_control_mouse_exited() -> void:
	clickable = false

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT and clickable == true:
			if $"../..".extractInt($jamCount.text) > 0 and $"../..".occupied == false:
				microwaveItem = "jam"
				microwaveItemRef = $"../..".addToMicrowave("jam_jar")
				microwaveItemRef.jamLimit = randi_range(3, 10)
				occupied = microwaveItemRef.occupied
				
				print("microwave item ref values:")
				print(microwaveItemRef.jamLimit)
			
