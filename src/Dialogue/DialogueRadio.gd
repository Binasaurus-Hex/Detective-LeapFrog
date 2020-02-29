extends Node

class_name DialogueRadio

signal dialogue_sent(dialogue)
func _ready() -> void:
	add_to_group("radio")
	pass
	
func send_dialogue(dialogue:String)->void:
	Events.emit_signal("send_dialogue",dialogue)
