extends Area2D

######################### Signal Variable ########################
signal picked_up



############################ Variable ############################
var textures = {
		"cherry" 	: "res://assets/sprites/cherry.png"
	, 	"gem" 		: "res://assets/sprites/cherry.png"
}



############################   User   ############################
func init( type, _position ):
	$Sprite2D.texture = load( textures[type] )
	position = _position
