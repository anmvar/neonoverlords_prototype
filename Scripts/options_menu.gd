extends Control

@onready var master_vol_slider: HSlider = $AudioMenu/AudioMenuVBox/MasterVolSlider
@onready var music_vol_slider: HSlider = $AudioMenu/AudioMenuVBox/MusicVolSlider
@onready var effects_vol_slider: HSlider = $AudioMenu/AudioMenuVBox/EffectsVolSlider



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	master_vol_slider.value = AudioServer.get_bus_volume_db(0)
	music_vol_slider.value = AudioServer.get_bus_volume_db(4)
	effects_vol_slider.value = AudioServer.get_bus_volume_db(1)
	pass # Replace with function body.
	
func value_to_db(value: float) -> float:
	if value == 0:
		return -80.0  # Silence
	return 20 * log(value) / log(10)  # Convert to dB

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_master_vol_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0,value_to_db(value))
	pass # Replace with function body.


func _on_music_vol_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(4,value_to_db(value))
	pass # Replace with function body.


func _on_effects_vol_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(1,value_to_db(value))
	pass # Replace with function body.
