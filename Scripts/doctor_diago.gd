extends CanvasLayer
var dialogue_box: CanvasLayer
func turn_off():
	dialogue_box = get_parent().get_node("Doctor diago")
	dialogue_box.visible = false
