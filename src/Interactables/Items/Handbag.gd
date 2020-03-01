extends Interactable


func _ready() -> void:
	pass
	
func action(player) -> void:
	dialogueRadio.send_dialogue("res://assets/Dialogue/Handbag.json")
