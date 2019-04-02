extends Button

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass


func _on_MuteSFX_pressed():
	if (AudioServer.get_fx_global_volume_scale() == 0):
		AudioServer.set_fx_global_volume_scale(1)
	else:
		AudioServer.set_fx_global_volume_scale(0)
	pass # replace with function body
