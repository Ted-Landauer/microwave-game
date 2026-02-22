extends Node2D

# Initialize the funds and viewership numbers
var funds: int = 0
var startingFunds: int = 300

var viewerNumbers: int = 0
var startingViewerNumbers: int = 10

var viewershipDeclineBuffer = true
var revenueMod: float = .01

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$InfoNumbers/ShoppingButton/UpgradeMenu.propagate_call("set_visible", [false])
	$InfoNumbers/ShoppingButton/UpgradeMenu.visible = false
	
	updateFunds(startingFunds, "+")
	updateViewship(startingViewerNumbers, "+")

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
		funds -= moneyValue
	
	$InfoNumbers/FundsValue.text = "$" + str(funds)



# Custom toInt method
func extractInt(numberString: String):
	var numberInt
	
	# Check if we've passed the funds value and strip of the NAN character
	if numberString[0] == "$":
		numberInt = int(numberString.rstrip("$"))
	
	numberInt = int(numberString)
	
	return numberInt




#if viewershipDeclineBuffer == true:
#		updateFunds(calculateRevenue(viewerNumbers, revenueMod), "+")

# Used for running the money and viewer calc every second
var t: float = 0.0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Increase t to make 
	t += delta
	if (viewershipDeclineBuffer == true and t >= 1.0):
		updateFunds(calculateRevenue(viewerNumbers, revenueMod), "+")
		t = 0.0
	elif viewershipDeclineBuffer == false and t >= 1.0 and viewerNumbers != 0:
		updateViewship(1, "-")
		t = 0.0
		
		
	
	


func _input(event: InputEvent) -> void:
	#var ParentShop = find_node("Shop")
	
	if event is InputEventKey and event.is_pressed():
		if event.keycode == KEY_ESCAPE:
			$InfoNumbers/ShoppingButton/UpgradeMenu.propagate_call("set_visible", [false])
			$InfoNumbers/ShoppingButton/UpgradeMenu.visible = false


func _on_shopping_button_pressed() -> void:
	if $InfoNumbers/ShoppingButton/UpgradeMenu.visible != true:
		$InfoNumbers/ShoppingButton/UpgradeMenu.propagate_call("set_visible", [true])
		$InfoNumbers/ShoppingButton/UpgradeMenu.visible = true
		



func _on_buy_egg_pressed() -> void:
	var eggsBought = extractInt($Groceries/egg/eggCount.text)
	var eggsCost = extractInt($InfoNumbers/ShoppingButton/UpgradeMenu/ColorRect/Labels/EggCost.text)
	eggsBought += 1
	$Groceries/egg/eggCount.text = str(eggsBought)
	
	updateFunds(eggsCost, "-")
	



func _on_buy_potato_pressed() -> void:
	var potatoBought = extractInt($Groceries/potato/potatoCount.text)
	var potatoCost = extractInt($InfoNumbers/ShoppingButton/UpgradeMenu/ColorRect/Labels/PotatoCost.text)
	
	potatoBought += 1
	$Groceries/potato/potatoCount.text = str(potatoBought)
	
	updateFunds(potatoCost, "-")
	



func _on_buy_jam_jar_pressed() -> void:
	var jamBought = extractInt($Groceries/jamJar/jamCount.text)
	var jamCost = extractInt($InfoNumbers/ShoppingButton/UpgradeMenu/ColorRect/Labels/JamJarCost.text)
	
	jamBought += 1
	$Groceries/jamJar/jamCount.text = str(jamBought)
	
	updateFunds(jamCost, "-")
	



func _on_buy_milk_pressed() -> void:
	var milkBought = extractInt($Groceries/milkJug/milkCount.text)
	var milkCost = extractInt($InfoNumbers/ShoppingButton/UpgradeMenu/ColorRect/Labels/MilkJugCost.text)
	
	milkBought += 1
	$Groceries/milkJug/milkCount.text = str(milkBought)
	
	updateFunds(milkCost, "-")
	



func _on_buy_pumpkin_pressed() -> void:
	var pumpkinBought = extractInt($Groceries/pumpkin/pumpkinCount.text)
	var pumpkinCost = extractInt($InfoNumbers/ShoppingButton/UpgradeMenu/ColorRect/Labels/PumpkinCost.text)
	
	pumpkinBought += 1
	$Groceries/pumpkin/pumpkinCount.text = str(pumpkinBought)
	
	updateFunds(pumpkinCost, "-")
	
