update_data = function (_visible) {
	show_data = _visible;
	if (_visible) {
		var _s = self;
		inspector_struct = {
			x : _s.x,
			y : _s.y,
			genre : _s.genre,
			target : _s.target.id,
			max_speed : _s.max_speed
		}
	}
}