x -= off_x
y -= off_y


update_data(show_data)
if (!keyboard_check(vk_shift)) {
	if (target_node == noone) {
		var _node = noone
		var _node_dist = infinity
		var _dist;
		var _stop = false;
		for (var i = 0; i < array_length(node.edges); i++) {
			try {
			for (var o = 0; o < array_length(target.closest_nodes); o++) {
				if (node.edges[i] == target.closest_nodes[o]) {
					follow_edge = node.edges[i]
					target_node = follow_edge.dest
					_stop = true;
				}
			}
			} catch (_e) {
				show_debug_message(_e.message)
				show_debug_message(target)
			}
		
			if (_stop) {
				break
			}
		
			_dist = point_distance(target.x, target.y, node.edges[i].dest.x, node.edges[i].dest.y)
			if (_dist < _node_dist) {
				_node_dist = _dist
				target_node = node.edges[i].dest
				follow_edge = node.edges[i]
			}
		}
	}

	if (!_move_to_target) {
		try {
			if (collision_point(x, y, target.doorway, false, true) != noone) {
				_move_to_target = true;
			}
		} catch (_e) {
	
		}
	}

	if (_move_to_target and _t_node == noone) {
		var _weight = follow_edge.weight
		_t_node = new Node(target)
		var _go_node = new Node(self)
		var _ret_node = new Node(self)
	
	
		_go_node.add_edge(_t_node, _weight) // go to target
		_t_node.add_edge(_ret_node, _weight) // return from target
		// from return, to existing nodes on follow_edge
		_ret_node.edges = [
			follow_edge,
			follow_edge.dest.get_edge(follow_edge.source)
		]
	
	
		node = _go_node
		target_node = _t_node
		follow_edge = _go_node.edges[0]
	}

	off_x = lerp((follow_edge.weight - 8)*off_scl_x, off_x, 0.9)
	off_y = lerp((follow_edge.weight - 8)*off_scl_y, off_y, 0.9)

	if (point_distance(x, y, target_node.x, target_node.y) > max_speed*2) {
		x += lengthdir_x(max_speed, follow_edge.direction)	
		y += lengthdir_y(max_speed, follow_edge.direction)	
	} else {
		
		x = target_node.x
		y = target_node.y
		
		
		if (target_node == entry.node) {
			instance_destroy();	
		}
	
		if (_t_node == node) {
			_t_node = noone
		} else if (_t_node == target_node) {
			_move_to_target = false
			// ADD PROFIT
			//show_debug_message("PURCHASE")
		
			array_delete(genre_booths, 0, 1)
			if (array_length(genre_booths) > 0) {
				target = genre_booths[0]
			} else {
				target = entry
			}
		}
	
		node = target_node
		target_node = noone

	}
	
	
	if (!point_in_rectangle(x, y, 0, 0, room_width, room_height)) {
		show_debug_message("ESCAPEE")
	}
}


x += off_x
y += off_y