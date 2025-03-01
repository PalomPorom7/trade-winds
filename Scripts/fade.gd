extends ColorRect

@export var _duration : float = 1
const CLEAR : Color = Color(0, 0, 0, 0)
var _tween : Tween

func to_clear() -> Signal:
	return _tween_color(CLEAR)

func to_black() -> Signal:
	return _tween_color(Color.BLACK)

func _tween_color(final_color : Color) -> Signal:
	if _tween and _tween.is_running():
		_tween.kill()
	_tween = create_tween()
	_tween.tween_property(self, "color", final_color, _duration)
	return _tween.finished
