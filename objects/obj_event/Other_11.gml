///@func allocate_booths(genre, scale)
///@param genre {EVENT_SETUP} - the type of rule to use for clumping genres
///@param scale {EVENT_SETUP} = the type of rule to use for scale across genres
allocate_booths = function (_genre, _scale) {
	genres = []
	booths = []
	
	for (var i = 0; i <= GENRE_NUM; i++) {
		genres[i] = 0
	}
	
	
	with (obj_booth) {
		other.genres[genre]++
		other.booths[array_length(other.booths)] = self
		genre = -1
	}
	
	array_sort(booths, function(_a, _b) {
		var ret = _a.y - _b.y;
		ret = ret == 0 ? _a.x - _b.x : ret
		return ret;
	})
	
	genre_order = []
	for (var i = 0; i < array_length(genres); i++) {
		genre_order[i] = i
	}
	// get the order for genre placement
	switch (_scale) {
		case EVENT_SETUP.GENRE_SCALE_SMOOTH: break;
		case EVENT_SETUP.GENRE_SCALE_ROUGH:
			var _temp, _other;
			var _c = 3;
			for (var i = 0; i < array_length(genre_order); i++) {
				// 3 split increment
				genre_order[i] = floor(i/_c) + (ceil(array_length(genre_order)/_c)) * (i % _c)
			}
		break;
		case EVENT_SETUP.GENRE_SCALE_RANDOM:
			var _temp, _other;
			for (var i = 0; i < array_length(genre_order); i++) {
				_other = irandom_range(i, array_length(genre_order)-1)
				_temp = genre_order[i]
				genre_order[i] = genre_order[_other]
				genre_order[_other] = _temp
			}
		break;
		default: throw("INCORRECT USE OF allocate_booths, scale INPUT IS INCORRECT.");
	}
	
	// place a single booth of each genre
	switch (_genre) {
		case EVENT_SETUP.GENRE_CLUMPED:
			var o = 0;
			for (var i = 0; i < array_length(booths); i++) {
				while (genres[genre_order[o]] <= 0) { o++ }
				booths[i].genre = genre_order[o]
				genres[genre_order[o]]--
			}
		break;
		case EVENT_SETUP.GENRE_SPREAD:
			var o = 0;
			for (var i = 0; i < array_length(booths); i++) {
				while (genres[genre_order[o]] <= 0) { o = (++o) % array_length(genre_order) }
				booths[i].genre = genre_order[o]
				genres[genre_order[o]]--
				o = (++o) % array_length(genre_order) 
			}
		break;
		case EVENT_SETUP.GENRE_RANDOM:
			var o = irandom(array_length(genre_order)-1);
			var _first = true;
			var _dir = 1
			for (var i = 0; i < array_length(booths); i++) {
				if (_scale == EVENT_SETUP.GENRE_SCALE_RANDOM) {
					o = irandom(array_length(genre_order) - 1)
					while (genres[genre_order[o]] <= 0) { 
						o = irandom(array_length(genre_order) - 1)
					}
				} else {
					// equal chance for up, down, stay
					_first = irandom(2) != 0
					_dir = 2*(irandom(1) - 0.5) 
					while (_first or genres[genre_order[o]] <= 0) { 
						_first = false;
						o = (o + _dir + array_length(genre_order)) % array_length(genre_order)
					}
				}
				booths[i].genre = genre_order[o]
				genres[genre_order[o]]--
			}
		break;
		default: throw("INCORRECT USE OF allocate_booths, genre INPUT IS INCORRECT.");
	}
	var _s = "\n"
	for (var i = 0; i < array_length(booths); i++) {
		_s += string(booths[i].genre) + ", "
	}
	show_debug_message(_s)
}