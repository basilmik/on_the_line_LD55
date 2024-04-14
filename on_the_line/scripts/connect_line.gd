extends Line2D

@onready var control = 	$".."
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	queue_redraw()
	pass


func _draw():
	draw_texture(texture, Vector2())
	if (control.is_holding):
		var from = control.item_held.get_position()
		var to = get_local_mouse_position()
		
		draw_line(from, to, Color(1, 1, 0.878431, 0.5), 0.5, true)#247, 201, 72
		
		
		
