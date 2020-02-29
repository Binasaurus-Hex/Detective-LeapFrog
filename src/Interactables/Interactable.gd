extends StaticBody2D

class_name Interactable

onready var dialogueRadio:DialogueRadio = $DialogueRadio
onready var area:Area2D = $Area2D
var player

func _ready() -> void:
	area.connect("body_entered",self,"_on_body_entered")
	area.connect("body_exited",self,"_on_body_exited")
	pass


func _on_body_entered(body:Node) -> void:
	if body.is_in_group("player"):
		body.on_interactable_entered(self)
		
func _on_body_exited(body:Node) -> void:
	if body.is_in_group("player"):
		body.on_interactable_exited()
		
func action(player):
	pass
