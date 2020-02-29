extends NinePatchRect

class_name DialogueBox

onready var _text:RichTextLabel = $Text

func _ready() -> void:
	Events.connect("send_dialogue",self,"setBuffer",[20])
	_text.text = ""
	pass
	
func setBuffer(text:String,speed:float) -> void:
	_text.bbcode_text = text
	_text.visible_characters = 0
	$Timer.wait_time = 1/speed
	$Timer.start()
	
func _process(delta: float) -> void:
	pass
	
func _show()->void:
	self.show()
	pass

func _hide()->void:
	self.hide()
	pass


func _on_Timer_timeout() -> void:
	_text.visible_characters += 1
	pass # Replace with function body.
