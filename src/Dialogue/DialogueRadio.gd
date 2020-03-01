extends Node

class_name DialogueRadio

signal dialogue_sent(dialogue)
func _ready() -> void:
	pass
	
func send_dialogue(filepath:String)->void:
	var dialogue = parse_file(filepath)
	print(dialogue)
	Events.emit_signal("send_dialogue",dialogue)
	
func parse_file(filepath):
	var file = File.new()
	file.open(filepath,File.READ)
	var text = file.get_as_text()
	var result_json = JSON.parse(text)
	if result_json.error == OK:  # If parse OK
		return result_json.result
	else:  # If parse has errors
		print("Error: ", result_json.error)
		print("Error Line: ", result_json.error_line)
		print("Error String: ", result_json.error_string)
	file.close()
