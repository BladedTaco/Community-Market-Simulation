update_data = function (_visible) {
	show_data = _visible;
	var _s = self
	if (_visible) {		
		inspector_struct = {
			x : _s.x,
			y : _s.y,
			name : object_get_name(_s.object_index)
		}
	}
}