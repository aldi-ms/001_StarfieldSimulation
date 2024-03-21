extends Sprite2D

var pos: Vector3
var size: Vector2
var speed: float
var prev_z: float

func _ready():
	speed = 1.0
	size = get_viewport().get_visible_rect().size
	pos = Vector3(
		randf_range(-size.x, size.x), 
		randf_range(-size.y, size.y), 
		randf_range(0, size.x))
		
	prev_z = pos.z
	
func _process(delta):
	# pos.z is the distance to the star
	pos.z -= 100 * delta * speed
	
	# move mouse left -> right to speed up
	speed = clampf(remap(get_global_mouse_position().x, 0, size.x, 0, 40), 0, 40)

	# check pos.z so we dont get division by 0 or negative z
	if pos.z < 1:
		pos.z = size.x
		pos.x = randf_range(-size.x, size.x)
		pos.y = randf_range(-size.y, size.y)
		prev_z = pos.z
	
	queue_redraw()

func _draw():
	# star position
	var dx = remap(pos.x / pos.z, 0, 1, 0, size.x)
	var dy = remap(pos.y / pos.z, 0, 1, 0, size.y)
	var r = remap(pos.z, 0, size.x, 16, 0)
	
	# streaking line
	var line_x = remap(pos.x / prev_z, 0, 1, 0, size.x)
	var line_y = remap(pos.y / prev_z, 0, 1, 0, size.y)
	#var line_width = remap(prev_z, 0, size.x, 2, 1)
	prev_z = pos.z
	
	draw_line(Vector2(dx, dy), Vector2(line_x, line_y), Color.WHITE, 1)
	draw_circle(Vector2(dx, dy), r, Color.WHITE)
	
