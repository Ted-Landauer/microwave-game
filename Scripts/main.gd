extends Node2D

# Initialize the funds and viewership numbers
var funds: int = 0
const STARTINGFUNDS: int = 300

var viewerNumbers: int = 0
const STARTINGVIEWERNUMBERS: int = 10

var viewershipDeclineBufferState: bool = true
var viewershipDeclineBuffer: int = 10
var revenueMod: float = .01

const GROCPATH: String = "res://Scenes/Groceries"
var groceries: Dictionary = {}

var occupied: bool = false
var lowCostMicroOwned: bool = true
var midCostMicroOwned: bool = false
var highCostMicroOwned: bool = false
var totalSeconds: int = 0
var countdownActive = false

var microwavedItem: String



# Load the resources in a directory into a dictionary for future use
func preloadResources(path: String, collection: Dictionary):
	
	# Open the requested directory
	var grocDir = DirAccess.open(path)
	
	# Check that we actually got something or print a statement for temp error handling
	if grocDir:
		
		# Open a stream to read in the contents of the directory and get the next value
		grocDir.list_dir_begin()
		var fileName = grocDir.get_next()
		
		# Loop over every item in the open directory
		while fileName != "":
			
			# Check if we found a directory in our parsing or if we found a scene
			if grocDir.current_is_dir():
				print("Found directory: " + fileName)
				
			elif fileName.get_extension() == "tscn":
				# Build the path to the scene we want to load
				var fullPath = path + "/" + fileName
				
				# Get the name of the resource to use a dictionary key
				var resourceName = fileName.get_basename()
				
				# Build our dictionary of loaded resources
				collection[resourceName] = load(fullPath).instantiate()
			
			# Step forward in the loop
			fileName = grocDir.get_next()
		
		# Close the stream for saftey's sake
		grocDir.list_dir_end()
	
	else:
		print("An error was encountered when opening the requested path")

func countdownMicrowaveTimer():
	var maxTimeArr = extractInt($Microwave/microwaveDisplay.text)
	var min = int(maxTimeArr[0])
	var sec = int(maxTimeArr[1])
	var strSec = ""
	
	if sec == 0:
		strSec = "59"
		min -= 1
	else:
		sec -= 1
		if sec < 10:
			strSec = "%02d" % sec
				
		$Microwave/microwaveDisplay.text = str(min) + ":" + strSec



func updateMicrowaveDisplay(min: int, sec: int):
	var strSec = str(sec)
	totalSeconds = (min * 60) + sec
	
	if sec < 10:
		strSec = "%02d" % sec
	
	$Microwave/microwaveDisplay.text = str(min) + ":" + strSec



func changeInventory(food: String, direction: String):
	var foodReference = get_node("Groceries/" + food + "/" + food + "Count")
	var foodBought = extractInt(foodReference.text)
	
	if direction == "+" and foodBought >= 0:
		foodBought += 1
	elif direction == "-" and foodBought > 0:
		foodBought -= 1
	
	foodReference.text = str(foodBought)



# Return the value of money gained per second
func calculateRevenue(view: int, modifier: float):
	var perSecGain: float
	
	perSecGain = view * modifier
	
	print("per second gain")
	print(perSecGain)
	
	return ceili(perSecGain)



# Update the viewership numbers
func updateViewship(viewerChange: int, direction: String):
	
	if direction == "+":
		viewerNumbers += viewerChange
	elif direction == "-":
		viewerNumbers -= viewerChange
	
	$InfoNumbers/viewerNumbers.text = str(viewerNumbers)



# Update the player's funds
func updateFunds(moneyValue: int, direction: String):
	
	if direction == "+":
		funds += moneyValue
	elif direction == "-":
		if funds - moneyValue < 0:
			print("Out of money")
		else:
			funds -= moneyValue
	
	$InfoNumbers/FundsValue.text = "$" + str(funds)



# Custom toInt method
func extractInt(numberString: String):
	var numberInt
	
	# Check if we've passed the funds value and strip of the NAN character
	if numberString[0] == "$":
		numberInt = int(numberString.rstrip("$"))
		return numberInt
	elif numberString.contains(":"):
		var tempHold = numberString.split(":")
		var tempMin = tempHold[0]
		var tempSec = tempHold[1]
		
		#numberInt = int(tempHold[])
		return tempHold
	
	numberInt = int(numberString)
	
	return numberInt

func addToMicrowave(item: String):
	print("add test")
	if occupied == false:
		var newItem = groceries[item]
		
		print("this is the item: " + item)
		
		newItem.position.x = 700
		newItem.position.y = 640
		newItem.z_index = 1
		add_child(newItem)
		print("added to microwave")
		
		microwavedItem = item
		print("the microwaved item: ")
		print(microwavedItem)
		print(typeof(microwavedItem))
		
		changeInventory(item.get_slice("_", 0), "-")
		occupied = true
		
		return newItem

func toggleButtons(toggle: bool):
	$Microwave/microwaveStart.disabled = toggle
	$Microwave/microwaveStart.toggle_mode = toggle
	
	$Microwave/thirtySeconds.disabled = toggle
	$Microwave/thirtySeconds.toggle_mode = toggle
	
	$Microwave/tenSeconds.disabled = toggle
	$Microwave/tenSeconds.toggle_mode = toggle
	
	$Microwave/fiveSeconds.disabled = toggle
	$Microwave/fiveSeconds.toggle_mode = toggle

# Called when the node enters the scene tree for the first time.
func _ready() -> void:	
	preloadResources(GROCPATH, groceries)
	
	$InfoNumbers/ShoppingButton/UpgradeMenu.propagate_call("set_visible", [false])
	$InfoNumbers/ShoppingButton/UpgradeMenu.visible = false
	
	updateFunds(STARTINGFUNDS, "+")
	updateViewship(STARTINGVIEWERNUMBERS, "+")
	
	$Microwave/microwaveStart/viewershipBuffer.one_shot = true
	$Microwave/microwaveStart/microwaveTimer.one_shot = true
	
	$Microwave/LowControlPanel.visible = false
	$Microwave/thirtySeconds.visible = true
	
	$Microwave/MidControlPanel.visible = false
	$Microwave/tenSeconds.visible = true
	
	$Microwave/HighControlPanel.visible = true
	$Microwave/fiveSeconds.visible = true
	


# Used for running the money and viewer calc every second in process below
var mu: float = 0.0
var vd: float = 0.0
var cd: float = 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	mu += delta
	if viewershipDeclineBufferState == true and mu >= 1.0:
		updateFunds(calculateRevenue(viewerNumbers, revenueMod), "+")
		mu = 0.0
	
	vd += delta
	if viewershipDeclineBufferState == false and vd >= 1.0 and viewerNumbers != 0:
		updateViewship(1, "-")
		vd = 0.0
	
	cd += delta
	if countdownActive == true and cd >= 1.0:
		countdownMicrowaveTimer()
		cd = 0.0

# Escape function for closing the shopping menu
func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed():
		if event.keycode == KEY_ESCAPE:
			$InfoNumbers/ShoppingButton/UpgradeMenu.propagate_call("set_visible", [false])

# Function to open the grrocery shopping menu
func _on_shopping_button_pressed() -> void:
	if $InfoNumbers/ShoppingButton/UpgradeMenu.visible == false:
		$InfoNumbers/ShoppingButton/UpgradeMenu.propagate_call("set_visible", [true])
		
	elif $InfoNumbers/ShoppingButton/UpgradeMenu.visible == true:
		$InfoNumbers/ShoppingButton/UpgradeMenu.propagate_call("set_visible", [false])
		#$InfoNumbers/ShoppingButton/UpgradeMenu.visible = false

func _on_buy_egg_pressed() -> void:
	var eggsCost = extractInt($InfoNumbers/ShoppingButton/UpgradeMenu/ColorRect/Labels/EggCost.text)
	
	changeInventory("egg", "+")
	updateFunds(eggsCost, "-")

func _on_buy_potato_pressed() -> void:
	var potatoCost = extractInt($InfoNumbers/ShoppingButton/UpgradeMenu/ColorRect/Labels/PotatoCost.text)
	
	changeInventory("potato", "+")
	updateFunds(potatoCost, "-")

func _on_buy_jam_jar_pressed() -> void:
	var jamCost = extractInt($InfoNumbers/ShoppingButton/UpgradeMenu/ColorRect/Labels/JamJarCost.text)
	
	changeInventory("jam", "+")
	updateFunds(jamCost, "-")

func _on_buy_milk_pressed() -> void:
	var milkCost = extractInt($InfoNumbers/ShoppingButton/UpgradeMenu/ColorRect/Labels/MilkJugCost.text)
	
	changeInventory("milk", "+")
	updateFunds(milkCost, "-")

func _on_buy_pumpkin_pressed() -> void:
	var pumpkinCost = extractInt($InfoNumbers/ShoppingButton/UpgradeMenu/ColorRect/Labels/PumpkinCost.text)
	
	changeInventory("pumpkin", "+")
	updateFunds(pumpkinCost, "-")

func _on_microwave_start_pressed() -> void:
	toggleButtons(true)
	
	$Microwave/microwaveStart/microwaveTimer.start(totalSeconds)
	print("pausing viewership decline")
	viewershipDeclineBufferState = true
	countdownActive = true
	

func _on_microwave_timer_timeout() -> void:
	print("timer stopped")
	toggleButtons(false)
	
	print("about to lose viewers")
	$Microwave/microwaveStart/viewershipBuffer.start(viewershipDeclineBuffer)
	countdownActive = false
	occupied = false
	
	match microwavedItem:
		"egg":
			remove_child($Groceries/egg.microwaveItemRef)
			print("removed egg")
		"jam":
			remove_child($Groceries/jam_jar.microwaveItemRef)
			print("removed jam")
		"milk":
			remove_child($Groceries/milk_jug.microwaveItemRef)
			print("removed milk")
		"potato":
			remove_child($Groceries/potato.microwaveItemRef)
			print("removed potato")
		"pumpkin":
			remove_child($Groceries/pumpkin.microwaveItemRef)
			print("removed pumpkin")
		

func _on_viewership_buffer_timeout() -> void:
	print("losing viewers")
	viewershipDeclineBufferState = false

func _on_thirty_seconds_pressed() -> void:
	var minSecArray = extractInt($Microwave/microwaveDisplay.text)
	var min = int(minSecArray[0])
	var sec = int(minSecArray[1])
	
	sec += 30
	if sec >= 60:
		min += 1
		sec = sec - 60
	
	updateMicrowaveDisplay(min, sec)

func _on_ten_seconds_pressed() -> void:
	var minSecArray = extractInt($Microwave/microwaveDisplay.text)
	var min = int(minSecArray[0])
	var sec = int(minSecArray[1])
	
	sec += 10
	if sec >= 60:
		min += 1
		sec = sec - 60
	
	updateMicrowaveDisplay(min, sec)

func _on_five_seconds_pressed() -> void:
	var minSecArray = extractInt($Microwave/microwaveDisplay.text)
	var min = int(minSecArray[0])
	var sec = int(minSecArray[1])
	
	sec += 5
	if sec >= 60:
		min += 1
		sec = sec - 60
	
	updateMicrowaveDisplay(min, sec)
