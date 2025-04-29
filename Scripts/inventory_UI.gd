extends Control

@onready var inv: Inventory = preload("res://scenes/player_inventory.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

var is_Open = false

func _ready():
	inv.update.connect(updateSlots)
	updateSlots()
	close()
	
func _process(delta):
	if Input.is_action_just_pressed("i"):
		if is_Open:
			close()
		else:
			open()
	
	
func close():
	visible = false
	is_Open = false
	
func open():
	visible = true
	is_Open = true

func updateSlots():
	for i in range(min(inv.slots.size(), slots.size())):
		slots[i].update_slot(inv.slots[i])
	
