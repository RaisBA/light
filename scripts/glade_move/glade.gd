tool
extends Sprite

func _ready():
	var nav = NavigationPolygonInstance.new()
	var polygon = NavigationPolygon.new()
	var outline = PoolVector2Array([Vector2(-32, -32), Vector2(-32, 32), Vector2(32, 32), Vector2(32, -32)])
	polygon.add_outline(outline)
	polygon.make_polygons_from_outlines()
	nav.navpoly = polygon
	add_child(nav)
