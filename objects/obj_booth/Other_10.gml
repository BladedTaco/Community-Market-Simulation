update_data = function (_visible) {
	trigger.visible = _visible;
	doorway.visible = _visible;
	show_data = _visible;
	var _s = self
	if (_visible) {		
		inspector_struct = {
			x : _s.x,
			y : _s.y,
			genre : _s.genre,
			trigger : _s.trigger,
			closest_nodes : _s.closest_nodes
		}
	}
}