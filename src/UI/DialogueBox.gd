extends NinePatchRect

class_name DialogueBox

onready var _text:RichTextLabel = $Text
var finished:bool = false
var showing = false

func _ready() -> void:
	rect_position.y += rect_size.y
	Events.connect("send_dialogue",self,"setBuffer",[20])
	_text.text = ""
	pass
	
func setBuffer(text:String,speed:float) -> void:
	_text.bbcode_text = text
	_text.visible_characters = 0
	$Timer.wait_time = 1/speed
	start()
	
func _process(delta: float) -> void:
	process_input()
	pass


func _on_Timer_timeout() -> void:
	_text.visible_characters += 1
	if _text.visible_characters == _text.get_total_character_count():
		$NextButton.wait()
		finished = true
		
	pass # Replace with function body.
	
func start() -> void:
	finished = false
	$Timer.start()
	if !showing:
		animated_show()
	Events.emit_signal("dialogue_show")
	
func stop() -> void:
	$Timer.stop()
	if showing:
		animated_hide()
	Events.emit_signal("dialogue_hide")
	
func process_input():
	if Input.is_action_just_pressed("ui_accept") and finished:
		progress()
	
func progress():
	stop()

func animated_show() -> void:
	showing = true
	$Tween.interpolate_property(self,"rect_position:y",rect_position.y,rect_position.y - rect_size.y,0.2)
	$Tween.start()
	pass
	
func animated_hide() -> void:
	showing = false
	$Tween.interpolate_property(self,"rect_position:y",rect_position.y,rect_position.y + rect_size.y,0.2)
	$Tween.start()
	pass
