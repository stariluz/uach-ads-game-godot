extends Node2D

func _ready():
	resetHangedMan()

func _on_score_manager_hangman_update(attemptNumber: int):
	match (attemptNumber):
		1: 
			$Head.visible = true
		2:
			$Torso.visible = true
		3:
			$ArmR.visible = true
		4:
			$ArmL.visible = true
		5:
			$LegR.visible = true
		6:
			$LegL.visible = true

func resetHangedMan():
	$Head.visible = false
	$LegL.visible = false
	$ArmL.visible = false
	$Torso.visible = false
	$LegR.visible = false
	$ArmR.visible = false

func _on_score_manager_reset_game():
	resetHangedMan()
