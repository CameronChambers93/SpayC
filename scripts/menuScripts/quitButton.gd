extends Button

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass


func _on_Quit_pressed():
	get_node("/root/global").setScene("res://MainMenu.tscn")
	for node in get_tree().get_root().get_children():
		print(node.get_filename())
#		if (node.get_name() == "Hello"):
#			print("MATCH")
	get_tree().set_pause(false)
	pass # replace with function body
