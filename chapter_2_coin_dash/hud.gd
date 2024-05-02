extends CanvasLayer


signal start_game


func update_score( value ):
	$MarginContainer/Score.text = str( value )



func update_time( value ):
	$MarginContainer/Time.text = str( value )