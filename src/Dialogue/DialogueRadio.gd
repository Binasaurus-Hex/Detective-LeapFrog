extends Node

signal dialogue_sent(dialogue)
func _ready() -> void:
	pass
	
func send_dialogue(dialog:String)->void:
	emit_signal("dialogue_sent",dialog)
