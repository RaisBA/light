extends Sprite

export (float) var total_size = 64
var nav

func _init():
	nav = NavigationPolygonInstance.new()
	var polygon = NavigationPolygon.new()
	var outline = PoolVector2Array([Vector2(- total_size/2, -total_size/2), Vector2(-total_size/2, total_size/2), Vector2(total_size/2, total_size/2), Vector2(total_size/2, -total_size/2)])
	polygon.add_outline(outline)
	polygon.make_polygons_from_outlines()
	nav.navpoly = polygon
	#add_child(nav)

func get_nav():
	return nav
