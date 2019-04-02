extends VBoxContainer


func _ready():
	pass

func _on_Play_pressed():
    pass


func _on_Options_pressed():
	get_tree().change_scene("res://OptionsMenu.tscn")


func _on_Credits_pressed():
	pass

func _on_Exit_pressed():
	get_tree().quit()


func _on_Back_pressed():
	get_tree().change_scene("res://MainMenu.tscn")


func _on_SoundEfx_pressed():
	get_tree().change_scene("res://SoundEfxMenu.tscn")


func _on_Controls_pressed():
	get_tree().change_scene("res://Controls.tscn")


func _on_BackToMainMenu_pressed():
	get_tree().change_scene("res://MainMenu.tscn")


func _on_HSlider_changed():
	pass


func _on_HSlider_value_changed( value ):
	print("hi")
	AudioServer.set_stream_global_volume_scale(value)
