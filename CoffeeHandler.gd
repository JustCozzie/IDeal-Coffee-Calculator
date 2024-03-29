extends Control
@onready var cup = $Background/MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer/Cup
@onready var drink_name = $Background/MarginContainer/HBoxContainer/VBoxContainer/DrinkName

@onready var espresso = $Background/MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer/Cup/ClipMask/Espresso
@onready var milk = $Background/MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer/Cup/ClipMask/Milk
@onready var froth = $Background/MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer/Cup/ClipMask/Froth
@onready var chocolate = $Background/MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer/Cup/ClipMask/Chocolate

@onready var espresso_slide = $Background/MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer/MarginContainer/HBoxContainer/EspressoSlide
@onready var milk_slide = $Background/MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer/MarginContainer/HBoxContainer/MilkSlide
@onready var froth_slide = $Background/MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer/MarginContainer/HBoxContainer/FrothSlide
@onready var chocolate_slide = $Background/MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer/MarginContainer/HBoxContainer/ChocolateSlide


@onready var slideList = [espresso_slide, milk_slide, froth_slide, chocolate_slide]

var cupSize
var cupLevel = 0

var espressVal = 0
var milkVal = 0
var frothVal = 0
var chocVal = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	cupSize = cup.get_size()
	var value = 0
	chocolate.set_custom_minimum_size(Vector2(0, (value / 100 * (0.95*cupSize.y))))
	froth.set_custom_minimum_size(Vector2(0, (value / 100 * (0.95*cupSize.y))))
	espresso.set_custom_minimum_size(Vector2(0, (value / 100 * (0.95*cupSize.y))))
	milk.set_custom_minimum_size(Vector2(0, (value / 100 * (0.95*cupSize.y))))
	
	calculateCupLevel()

func calculateCupLevel():
	var largestVal = 0
	for slide in slideList:
		if slide.value > largestVal:
			largestVal = slide.value
	cupLevel = largestVal


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if cup.get_size() != cupSize:
			cupSize = cup.get_size()
	
	if milk_slide.value < espressVal:
		milk_slide.value = espressVal
	if froth_slide.value < espressVal:
		froth_slide.value = espressVal
	if chocolate_slide.value < espressVal:
		chocolate_slide.value = espressVal
	
	if froth_slide.value < milkVal:
		froth_slide.value = milkVal
	if froth_slide.value < chocVal:
		froth_slide.value = chocVal
	if milk_slide.value < chocVal:
		milk_slide.value = chocVal
	
	drink_name.text = "[wave amp=50.0 freq=5.0 connected=1][center] Cuplevel: %s ChocVal %s [/center][/wave]" % [cupLevel, chocVal]


func _on_espresso_slide_value_changed(value):
	espresso.set_custom_minimum_size(Vector2(0, (value / 100 * (0.95*cupSize.y))))
	calculateCupLevel()
	espressVal = value


func _on_milk_slide_value_changed(value):
	milk.set_custom_minimum_size(Vector2(0, (value / 100 * (0.95*cupSize.y))))
	calculateCupLevel()
	milkVal = value

func _on_froth_slide_value_changed(value):
	froth.set_custom_minimum_size(Vector2(0, (value / 100 * (0.95*cupSize.y))))
	calculateCupLevel()
	frothVal = value
	
func _on_chocolate_slide_value_changed(value):
	chocolate.set_custom_minimum_size(Vector2(0, (value / 100 * (0.95*cupSize.y))))
	calculateCupLevel()
	chocVal = value
