class_name Facing

enum CARDINAL {UP, RIGHT, DOWN, LEFT}

static var _radianAngles := {
	CARDINAL.UP: 0,
	CARDINAL.RIGHT: PI / 2,
	CARDINAL.DOWN: PI,
	CARDINAL.LEFT: 3 * PI / 2
}

static func radian(dir: Facing.CARDINAL) -> float:
	return _radianAngles[dir]

static func adjacent(dir: Facing.CARDINAL, pos: Vector2, shift: int) -> Vector2:
	var x = pos.x
	var y = pos.y
	match dir:
		CARDINAL.UP:
			y -= shift
		CARDINAL.RIGHT:
			x += shift
		CARDINAL.DOWN:
			y += shift
		CARDINAL.LEFT:
			x -= shift
	return Vector2(x, y)

static func opposite(dir: Facing.CARDINAL) -> Facing.CARDINAL:
	match dir:
		CARDINAL.UP:
			return CARDINAL.DOWN
		CARDINAL.RIGHT:
			return CARDINAL.LEFT
		CARDINAL.DOWN:
			return CARDINAL.UP
		CARDINAL.LEFT:
			return CARDINAL.RIGHT
	push_error("Invalid CARDINAL passed: " + str(dir))
	return dir

static func all() -> Array[CARDINAL]:
	return [ CARDINAL.UP, CARDINAL.RIGHT, CARDINAL.DOWN, CARDINAL.LEFT ]

static func allExcept(dir: CARDINAL) -> Array[CARDINAL]:
	var arr = all()
	return arr.filter(func(c): return c != dir)
