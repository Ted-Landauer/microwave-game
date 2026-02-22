extends Node2D

# Initialize the overall funds value and the starting funds value
var funds: int = 0
var startingFunds: int = 300

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ShoppingButton/UpgradeMenu.propagate_call("set_visible", [false])
	$ShoppingButton/UpgradeMenu.visible = false
	
	updateFunds(startingFunds, "+")



func updateFunds(moneyValue: int, direction: String):
	
	if direction == "+":
		funds += moneyValue
	elif direction == "-":
		funds -= moneyValue
	
	$ShoppingButton/UpgradeMenu/ColorRect/Labels/FundsValue.text = "$" + str(funds)



# Custom toInt method
func extractInt(numberString: String):
	var numberInt
	
	# Check if we've passed the funds value and strip of the NAN character
	if numberString[0] == "$":
		numberInt = int(numberString.rstrip("$"))
	
	numberInt = int(numberString)
	
	return numberInt



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _input(event: InputEvent) -> void:
	#var ParentShop = find_node("Shop")
	
	if event is InputEventKey and event.is_pressed():
		if event.keycode == KEY_ESCAPE:
			$ShoppingButton/UpgradeMenu.propagate_call("set_visible", [false])
			$ShoppingButton/UpgradeMenu.visible = false


func _on_shopping_button_pressed() -> void:
	if $ShoppingButton/UpgradeMenu.visible != true:
		$ShoppingButton/UpgradeMenu.propagate_call("set_visible", [true])
		$ShoppingButton/UpgradeMenu.visible = true
		



func _on_buy_egg_pressed() -> void:
	var eggsBought = extractInt($Groceries/egg/eggCount.text)
	var eggsCost = extractInt($ShoppingButton/UpgradeMenu/ColorRect/Labels/EggCost.text)
	eggsBought += 1
	$Groceries/egg/eggCount.text = str(eggsBought)
	
	updateFunds(eggsCost, "-")
	



func _on_buy_potato_pressed() -> void:
	var potatoBought = extractInt($Groceries/potato/potatoCount.text)
	var potatoCost = extractInt($ShoppingButton/UpgradeMenu/ColorRect/Labels/PotatoCost.text)
	
	potatoBought += 1
	$Groceries/potato/potatoCount.text = str(potatoBought)
	
	updateFunds(potatoCost, "-")
	



func _on_buy_jam_jar_pressed() -> void:
	var jamBought = extractInt($Groceries/jamJar/jamCount.text)
	var jamCost = extractInt($ShoppingButton/UpgradeMenu/ColorRect/Labels/JamJarCost.text)
	
	jamBought += 1
	$Groceries/jamJar/jamCount.text = str(jamBought)
	
	updateFunds(jamCost, "-")
	



func _on_buy_milk_pressed() -> void:
	var milkBought = extractInt($Groceries/milkJug/milkCount.text)
	var milkCost = extractInt($ShoppingButton/UpgradeMenu/ColorRect/Labels/MilkJugCost.text)
	
	milkBought += 1
	$Groceries/milkJug/milkCount.text = str(milkBought)
	
	updateFunds(milkCost, "-")
	



func _on_buy_pumpkin_pressed() -> void:
	var pumpkinBought = extractInt($Groceries/pumpkin/pumpkinCount.text)
	var pumpkinCost = extractInt($ShoppingButton/UpgradeMenu/ColorRect/Labels/PumpkinCost.text)
	
	pumpkinBought += 1
	$Groceries/pumpkin/pumpkinCount.text = str(pumpkinBought)
	
	updateFunds(pumpkinCost, "-")
	
