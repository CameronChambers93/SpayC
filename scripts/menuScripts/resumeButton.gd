extends Button

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass


func _on_Resume_pressed():
	get_node("../../pause_popup").hide()
	get_tree().set_pause(false)
	pass # replace with function body
