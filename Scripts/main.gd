extends Node2D

#@onready shop = $ShoppingButton/UpgradeMenu

var funds: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ShoppingButton/UpgradeMenu.propagate_call("set_visible", [false])
	$ShoppingButton/UpgradeMenu.visible = false
	funds = int($ShoppingButton/UpgradeMenu/ColorRect/Labels/FundsValue.text.rstrip("$"))




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
	var eggsBought = int($Groceries/egg/eggCount.text)
	eggsBought += 1
	$Groceries/egg/eggCount.text = str(eggsBought)
	funds -= int($ShoppingButton/UpgradeMenu/ColorRect/Labels/EggCost.text)
	$ShoppingButton/UpgradeMenu/ColorRect/Labels/FundsValue.text = "$" + str(funds)
	

func _on_buy_potato_pressed() -> void:
	var potatoBought = int($Groceries/potato/potatoCount.text)
	potatoBought += 1
	$Groceries/potato/potatoCount.text = str(potatoBought)
	funds -= int($ShoppingButton/UpgradeMenu/ColorRect/Labels/PotatoCost.text)
	$ShoppingButton/UpgradeMenu/ColorRect/Labels/FundsValue.text = "$" + str(funds)

func _on_buy_jam_jar_pressed() -> void:
	var jamBought = int($Groceries/jamJar/jamCount.text)
	jamBought += 1
	$Groceries/jamJar/jamCount.text = str(jamBought)
	funds -= int($ShoppingButton/UpgradeMenu/ColorRect/Labels/JamJarCost.text)
	$ShoppingButton/UpgradeMenu/ColorRect/Labels/FundsValue.text = "$" + str(funds)

func _on_buy_milk_pressed() -> void:
	var milkBought = int($Groceries/milkJug/milkCount.text)
	milkBought += 1
	$Groceries/milkJug/milkCount.text = str(milkBought)
	funds -= int($ShoppingButton/UpgradeMenu/ColorRect/Labels/MilkJugCost.text)
	$ShoppingButton/UpgradeMenu/ColorRect/Labels/FundsValue.text = "$" + str(funds)

func _on_buy_pumpkin_pressed() -> void:
	var pumpkinBought = int($Groceries/pumpkin/pumpkinCount.text)
	pumpkinBought += 1
	$Groceries/pumpkin/pumpkinCount.text = str(pumpkinBought)
	funds -= int($ShoppingButton/UpgradeMenu/ColorRect/Labels/PumpkinCost.text)
	$ShoppingButton/UpgradeMenu/ColorRect/Labels/FundsValue.text = "$" + str(funds)
