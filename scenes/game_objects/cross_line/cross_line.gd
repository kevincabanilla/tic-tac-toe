extends Line2D
class_name CrossLine

@export var start_point: Vector2
@export var end_point: Vector2
@export var duration := 0.3

var elapsed := 0.0
var tween_animation: Tween


# Method 1
# lerp() smoothly interpolates between the two vectors.
# The second point moves toward end_point.
# The line visually grows.

#func _ready():
	#clear_points()
	#add_point(start_point)
	#add_point(start_point) # start collapsed
	#print("CrossLine ready.")
#
#
#func _process(delta):
	#if elapsed < duration:
		#elapsed += delta
		#var t = clamp(elapsed / duration, 0.0, 1.0)
		#var current_point = start_point.lerp(end_point, t)
		#set_point_position(1, current_point)


# Method 2: Using a Tween (Cleaner & Easier)
func _ready():
	clear_points()
	add_point(start_point)
	add_point(start_point)

	tween_animation = create_tween()
	tween_animation.tween_method(update_line, start_point, end_point, duration)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_OUT)


func update_line(value: Vector2):
	set_point_position(1, value)
	
	
# Method 3: Expanding by Distance (If You Only Know Direction)
# put in process or tween method
#var direction = (end_point - start_point).normalized()
#var max_length = start_point.distance_to(end_point)
#var current_length = max_length * t
#var current_point = start_point + direction * current_length
