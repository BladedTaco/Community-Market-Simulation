// booths that will only be walked to.
genre = irandom(GENRE_NUM)
// booths that will be window-shopped, but not walked to.
subgenre = irandom(GENRE_NUM)

genre_booths = []
subgenre_booths = []
window_shops = 0

while (array_length(genre_booths) == 0) {
	with (obj_booth) {
		//genre booths
		if (genre == other.genre) {
			if (RAND < PREF_GENRE_CHANCE) {
				other.genre_booths[array_length(other.genre_booths)] = self
			}
		} else if (abs(genre - other.genre) < 2) {
			if (RAND < NEIGH_GENRE_CHANCE) {
				other.genre_booths[array_length(other.genre_booths)] = self
			}
		}
		//subgenre booths
		if (genre == other.subgenre) {
			if (RAND < PREF_SUBGENRE_CHANCE) {
				other.subgenre_booths[array_length(other.subgenre_booths)] = self
			}
		} else if (abs(genre - other.subgenre) < 2) {
			if (RAND < NEIGH_SUBGENRE_CHANCE) {
				other.subgenre_booths[array_length(other.subgenre_booths)] = self
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



off_scl_x = 0.5 - random(1)
off_scl_y = 0.5 - random(1)

off_x = 24 - irandom(48)
off_y = 24 - irandom(48)

x += off_x
y += off_y


// nodes
_move_to_target = false;
_off_graph = false;
_t_node = new Node(self)
_s_node = new Node(self)
_g_node = new Node(self)

_g_node.add_edge(_t_node, 1) // go to target
_t_node.add_edge(_s_node, 1) // return from target


event_inherited()