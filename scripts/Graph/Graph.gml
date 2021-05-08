///@func Graph(nodes)
///@param {Object[]} nodes - an array of objects that have x and y implemented
///@desc Constructs an edgeless graph with the given objects as nodes.
function Graph(_nodes) constructor {
	// turn objects into Node instances.
	nodes = []
	for (var i = 0; i < array_length(_nodes); i++) {
		nodes[i] = new Node(_nodes[i]);
	}
	edges = []
	
	///@func generate_edges(obstacle)
	///@param {Object} obstacle - an object that blocks the creation of an edge.
	///@desc creates edges between Nodes that dont have obstacle instances in the way
	static generate_edges = function (_obstacle) {
		// clear edges
		edges = []	
		
		// create new edges
		var home, dest;
		for (var i = 0; i < array_length(nodes); i++) {
			for (var o = 0; o < array_length(nodes); o++) {
				if (i != o) {
					home = nodes[i]
					dest = nodes[o]
					// no obstructions
					if (collision_line(home.x, home.y, dest.x, dest.y, _obstacle, false, true) == noone) {
						var _inst = instance_nearest(lerp(home.x, dest.x, 0.5), lerp(home.y, dest.y, 0.5), _obstacle);
						_inst = _inst == noone ? -infinity : max(abs(lerp(home.x, dest.x, 0.5) - _inst.x) , abs(lerp(home.y, dest.y, 0.5) - _inst.y))
						home.add_edge(dest, _inst);
					}
				}
			}
		}
		
		// trim overlapping edges
		for (var i = 0; i < array_length(nodes); i++) {
			home = nodes[i]
			for (var o = 0; o < array_length(home.edges); o++) {
				for (var j = o+1; j < array_length(home.edges); j++) {
					if (abs(angle_difference(
						point_direction(home.edges[o].source.x, home.edges[o].source.y, home.edges[o].dest.x, home.edges[o].dest.y),
						point_direction(home.edges[j].source.x, home.edges[j].source.y, home.edges[j].dest.x, home.edges[j].dest.y) 
					)) < 5) {
						
						if (
							point_distance(home.x, home.y, home.edges[o].dest.x, home.edges[o].dest.y) <
							point_distance(home.x, home.y, home.edges[j].dest.x, home.edges[j].dest.y)
						) {
							array_delete(home.edges, j, 1)
						} else {
							array_delete(home.edges, o, 1)
						}
						j--// = o
					}
				}
			}
		}
	}
	
	///@func overlapping_edges(object)
	///@param object - the object to check for overlap with.
	///@desc returns all edges that overlap object
	static overlapping_edges = function(_object) {
		ret = []
		for (var i = 0; i < array_length(nodes); i++) {
			home = nodes[i]
			for (var o = 0; o < array_length(home.edges); o++) {
				edge = home.edges[o]
				if (collision_line(edge.source.x, edge.source.y, edge.dest.x, edge.dest.y, _object, false, false)) {
					ret[array_length(ret)] = edge
				}
			}	
		}
		return ret
	}
	
	///@func closest_node(_object)
	///@param _object - an object with x and y position
	///@desc returns the closest node to the given object
	static closest_node = function (_object) {	
		var _closest, _closest_dist, _dist;
		_closest = noone;
		_closest_dist = infinity;
		for (var i = 0; i < array_length(nodes); i++) {
			_dist = point_distance(_object.x, _object.y, nodes[i].x, nodes[i].y)
			if (_dist < _closest_dist) {
				_closest_dist = _dist
				_closest = nodes[i]
			}
		}
		return _closest
	}
	
	///@func draw_edges()
	///@desc draws the edges of the graph one node at a time, cycling through
	static draw_edges = function() {
		static i = 0;
		
		if (keyboard_check(vk_control)) {
			if (!keyboard_check(vk_shift)) {
				i = (i + 0.02) % array_length(nodes)
			}
		
			nodes[floor(i)].draw_edges();
		
			draw_circle(nodes[floor(i)].x, nodes[floor(i)].y, 5, true)
		} else {
			for (var i = 0; i < array_length(nodes); i++) {
				nodes[i].draw_edges();
			}
		}
	}
}

///@func Node(object)
///@param {Object} object - the object to turn into a Node, must have x and y
///@desc creates a Node from object.
function Node(_obj) constructor {
	x = _obj.x
	y = _obj.y
	edges = []
	
	static add_edge = function (_edgeNode, _weight) {
		edges[array_length(edges)] = new Edge(self, _edgeNode, _weight)
	}
	
	static get_edge = function (_to) {
		for (var i = 0; i < array_length(edges); i++) {
			if (edges[i].dest == _to) {
				return edges[i]
			}
		}
	}
	
	static draw_edges = function() {
		for (var i = 0; i < array_length(edges); i++) {
			edges[i].draw_edge();
		}
	}
	
	static toString = function () {
		return "{ " + string(x) + ", " + string(y) + " }"	
	}
}

function Edge(_start, _end, _weight) constructor {
	source = _start;
	dest = _end;
	weight = _weight
	direction = point_direction(source.x, source.y, dest.x, dest.y)
	
	static draw_edge = function() {
		draw_set_alpha(0.3)
		draw_set_colour(merge_colour(c_white, c_red, weight/128))
		draw_line(source.x, source.y, dest.x, dest.y)
		draw_set_alpha(1)
		
		draw_text((source.x + dest.x)/2, (source.y + dest.y)/2, string(weight))
	}
	
	static toString = function () {
		return "{ (" + string(source.x) + ", " + string(source.y) + ") -> " + "(" + string(dest.x) + ", " + string(dest.y) + ") }"	
	}
}