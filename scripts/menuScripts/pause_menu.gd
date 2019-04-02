extends TextureButton

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	set_process(true)
	pass

func _on_TextureButton_pressed():
	get_node("../../pause_popup").hide()
	get_tree().set_pause(false)
	pass # replace with function body
