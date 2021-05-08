genre = irandom(GENRE_NUM)

genre_booths = []

while (array_length(genre_booths) == 0) {
	with (obj_booth) {
		if (genre == other.genre) {
			if (random(100) < PREF_GENRE_CHANCE) {
				other.genre_booths[array_length(other.genre_booths)] = self
			}
		} else if (abs(genre - other.genre) < 2) {
			if (random(100) < NEIGH_GENRE_CHANCE) {
				other.genre_booths[array_length(other.genre_booths)] = self
			}
		}
	}
}

node = noone
entry = noone
target_node = noone
follow_edge = noone

max_speed = AGENT_SPEED

if (array_length(genre_booths) > 0) {
	target = genre_booths[0]
} else {
	target = entry
}


_move_to_target = false;
_t_node = noone


show_data = false;

inspector_struct = {}

update_data = function (_visible) {
	show_data = _visible;
	if (_visible) {
		var _s = self;
		inspector_struct = {
			x : _s.x,
			y : _s.y,
			genre : _s.genre,
			target : _s.target.id
		}
	}
}



off_scl_x = 0.5 - random(1)
off_scl_y = 0.5 - random(1)

off_x = 24 - irandom(48)
off_y = 24 - irandom(48)

x += off_x
y += off_y