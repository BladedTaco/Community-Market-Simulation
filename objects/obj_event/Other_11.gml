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
		//genre = -1
	}
	
	array_sort(booths, function(_a, _b) {
		var ret = _a.y - _b.y;
		ret = ret == 0 ? _a.x - _b.x : ret
		return ret;
	})
	
	switch (_genre) {
		case EVENT_SETUP.GENRE_CLUMPED:
			
		break;
		case EVENT_SETUP.GENRE_SPREAD:
		
		break;
		case EVENT_SETUP.GENRE_RANDOM:
		
		break;
		default: throw("INCORRECT USE OF allocate_booths, genre INPUT IS INCORRECT.");
	}
	switch (_scale) {
		case EVENT_SETUP.GENRE_SCALE_SMOOTH:
		
		break;
		case EVENT_SETUP.GENRE_SCALE_ROUGH:
		
		break;
		case EVENT_SETUP.GENRE_SCALE_RANDOM:
		
		break;
		default: throw("INCORRECT USE OF allocate_booths, scale INPUT IS INCORRECT.");
	}
}