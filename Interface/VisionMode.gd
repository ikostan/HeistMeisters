extends CanvasModulate

const DARKNESS = Color('1c1e1c')
const NIGHTVISION = Color('2e7537') 

var cooldown: bool = false


func change_vision_mode():
	
	if not cooldown:
		
		cooldown = true
		
		if color == DARKNESS:
			night_vision_mode()
		else:
			dark_vision_mode()
		
		$VisionModeTimer.start()


func dark_vision_mode():
	color = DARKNESS
	$NightVisionOff.play()


func night_vision_mode():
	color = NIGHTVISION
	$NightVisionOn.play()


func _ready():
	color = DARKNESS
	visible = true


func _on_VisionModeTimer_timeout():
	cooldown = false
