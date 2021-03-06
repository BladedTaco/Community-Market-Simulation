x -= off_x
y -= off_y


if (!keyboard_check(vk_shift)) {
	if (target_node == noone) {
		if (follow_edge != noone) {
			follow_edge.tick(false)
		}
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
						break
					}
				}
				if (RAND < SUBGENRE_CHANCE) {
					for (var j = 0; j < array_length(subgenre_booths); j++) {
						for (var o = 0; o < array_length(subgenre_booths[j].closest_nodes); o++) {
							if (node.edges[i] == subgenre_booths[j].closest_nodes[o]) {
								follow_edge = node.edges[i]
								target_node = follow_edge.dest
								_stop = true;
								
								// remove from subgenre booths
								target = subgenre_booths[j]
								array_insert(genre_booths, 0, target)
								array_delete(subgenre_booths, j, 1)
								window_shops++
								break
							}
						}
						if (_stop) break
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
			if (_dist < _node_dist or ((follow_edge.speed_mul < AGENT_CROWDED_AVOID) and (follow_edge.speed_mul < node.edges[i].speed_mul))) {
				_node_dist = _dist
				target_node = node.edges[i].dest
				follow_edge = node.edges[i]
			}
		}
		
		if (follow_edge != noone) {
			follow_edge.tick(true)
		}
	}

	if (!_move_to_target) {
		if (variable_instance_exists(target, "doorway")) {
			if (collision_point(x, y, target.doorway, false, true) != noone) {
				_move_to_target = true;
			}
		}
	}

	if (_move_to_target and !_off_graph) {
		_off_graph = true;
		image_blend = c_green
		var _weight = follow_edge.weight
		//_t_node = new Node(target)
		//_g_node = new Node(self)
		//_s_node = new Node(self)
		// set pos
		_t_node.x = target.x
		_t_node.y = target.y
		_g_node.x = x
		_g_node.y = y
		_s_node.x = x
		_s_node.y = y
	
		// set weight
		_g_node.edges[0].weight = AGENT_SIZE/AGENT_CROWDED_FILL
		//_g_node.edges[0].weight = _weight
		_g_node.edges[0].update()
		//_t_node.edges[0].weight = _weight
		_t_node.edges[0].weight = AGENT_SIZE/AGENT_CROWDED_FILL
		_t_node.edges[0].update()
		
		// set edges to get back on graph
		_s_node.edges = [
			follow_edge,
			follow_edge.dest.get_edge(follow_edge.source)
		]
	
		follow_edge.tick(false);
	
		node = _g_node
		target_node = _t_node
		follow_edge = _g_node.edges[0]
	}

	off_x = lerp((follow_edge.weight/follow_edge.length - 8)*off_scl_x, off_x, 0.9)
	off_y = lerp((follow_edge.weight/follow_edge.length - 8)*off_scl_y, off_y, 0.9)

	var _w = follow_edge.speed_mul
	if (point_distance(x, y, target_node.x, target_node.y) > _w*max_speed*2) {
		x += lengthdir_x(max_speed*_w, follow_edge.direction)	
		y += lengthdir_y(max_speed*_w, follow_edge.direction)	
	} else {
		
		x = target_node.x
		y = target_node.y
		
		
		if (target_node == entry.node) {
			instance_destroy();	
			exit;
		}
	
		if (_t_node == node) {
			_off_graph = false
			image_blend = c_white
		} else if (_t_node == target_node) {
			_move_to_target = false
			// ADD PROFIT
			//show_debug_message("PURCHASE")
			target.sales++
		
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
}


x += off_x
y += off_y