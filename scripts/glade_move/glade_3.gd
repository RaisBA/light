extends StaticBody2D

export (float) var total_size = 64
var nav
func _init():
	nav = NavigationPolygonInstance.new()
	var polygon = NavigationPolygon.new()
	var outline = PoolVector2Array([
		Vector2(-32, -32), 
		Vector2(32, -32),
		Vector2(32, 32),
		Vector2(-32, 32),
		Vector2(-32, 0),
		Vector2(-6, 0),
		Vector2(-6, 15),
		Vector2(6, 15),
		Vector2(6, -6),
		Vector2(-6, -6),
		Vector2(-6, 0),
		Vector2(-32, 0)
	])
	polygon.add_outline(outline)
	polygon.make_polygons_from_outlines()
	nav.navpoly = polygon
	#add_child(nav)

func get_nav():
	return nav
