extends Panel

@onready var item_visual: Sprite2D = $CenterContainer/Panel/item_display

func update_slot(slot: invSlot):
	if !slot.item: 
		item_visual.visible = false
	else:
		item_visual.visible = true
		item_visual.texture = slot.item.texture
