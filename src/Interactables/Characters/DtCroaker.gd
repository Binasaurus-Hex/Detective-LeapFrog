extends Interactable


func _ready() -> void:
	pass
	
func action(player):
	dialogueRadio.send_dialogue("res://assets/Dialogue/Kroaker.json")
