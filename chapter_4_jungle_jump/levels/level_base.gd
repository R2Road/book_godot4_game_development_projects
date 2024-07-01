extends Node2D



############################ Override ############################
func _ready():
	$Items.hide()
	$Player.reset( $SpawnPoint.position )
