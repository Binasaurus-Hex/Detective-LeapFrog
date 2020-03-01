extends RichTextLabel

class_name TextDisplay

signal finished_playing_character
var buffer:Array
var phrase_index = 0
var finished_line:bool = false
var current_text:String

func _ready() -> void:
	$NextButton.connect("line_finished",self,"on_line_finished")
	pass
	
func on_line_finished():
	phrase_index += 1
	if phrase_index +1 > buffer.size():
		emit_signal("finished_playing_character")
	else:
		play_phrase(buffer[phrase_index],20)
	
func set_buffer(phraseList:Array) -> void:
	print("buffer set")
	clear()
	buffer = phraseList
	play_phrase(buffer[phrase_index],20)
	
func clear() -> void:
	buffer = []
	bbcode_text = ""
	phrase_index = 0
	visible_characters = 0
	current_text = ""
	
func play_phrase(phrase:String,speed:int):
	$Timer.wait_time = 1.0/speed
	current_text += phrase + "\n"
	bbcode_text += phrase + "\n"
	$Timer.start()
	
func _on_Timer_timeout() -> void:
	visible_characters += 1
	if visible_characters == current_text.length():
		$Timer.stop()
		$NextButton.show_btn()
		
