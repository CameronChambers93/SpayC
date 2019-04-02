extends Node


func _ready():
	pass

func _on_Play_pressed():
	#get_tree().change_scene("res://Environment.tscn")
	get_node("/root/global").setScene("res://Environment.tscn")
	#print(get_node("/root/global"))


func _on_Options_pressed():
	#get_tree().change_scene("res://scenes/menuScenes/OptionsMenu.tscn")
	get_node("/root/global").setScene("res://scenes/menuScenes/OptionsMenu.tscn")


func _on_Credits_pressed():
	#get_tree().change_scene("res://scenes/menuScenes/Credits.tscn")
	get_node("/root/global").setScene("res://scenes/menuScenes/Credits.tscn")

func _on_Exit_pressed():
	get_tree().quit()


func _on_Back_pressed():
	#get_tree().change_scene("res://scenes/menuScenes/MainMenu.tscn")
	get_node("/root/global").setScene("res://scenes/menuScenes/MainMenu.tscn")


func _on_SoundEfx_pressed():
	#get_tree().change_scene("res://scenes/menuScenes/SoundEfxMenu.tscn")
	get_node("/root/global").setScene("res://scenes/menuScenes/SoundEfxMenu.tscn")


func _on_Controls_pressed():
	#get_tree().change_scene("res://scenes/menuScenes/Controls.tscn")
	get_node("/root/global").setScene("res://scenes/menuScenes/Controls.tscn")


func _on_BackToMainMenu_pressed():
	#get_tree().change_scene("res://scenes/menuScenes/MainMenu.tscn")
	get_node("/root/global").setScene("res://scenes/menuScenes/MainMenu.tscn")


func _on_HSlider1_value_changed( value ):
	AudioServer.set_stream_global_volume_scale(value)


func _on_Button_2_pressed():
	#get_tree().change_scene("res://scenes/menuScenes/MainMenu.tscn")
	get_node("/root/global").setScene("res://scenes/menuScenes/MainMenu.tscn")


func _on_HSlider2_value_changed( value ):
	AudioServer.set_fx_global_volume_scale(value)


func _on_Button_pressed():
	#get_tree().change_scene("res://scenes/menuScenes/MainMenu.tscn")
	get_node("/root/global").setScene("res://scenes/menuScenes/MainMenu.tscn")
