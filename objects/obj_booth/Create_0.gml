trigger = instance_create_depth(x, y + 64*image_yscale, depth, obj_trigger);
trigger.owner = self;
trigger.image_xscale = 3;
trigger.image_yscale = 3;

doorway = instance_create_depth(x, y + 64*image_yscale, depth, obj_trigger);
doorway.owner = self;
doorway.image_yscale = 3;

show_data = false;
closest_nodes = []
inspector_struct = {}

genre = irandom(GENRE_NUM)



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