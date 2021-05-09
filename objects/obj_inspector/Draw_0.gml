
if (target != noone && instance_exists(target)) {
	target.update_data(false)
}


// set target as the topmost object, closest to the mouse.
var _ds = ds_list_create()
target = noone;
if (collision_point_list(mouse_x, mouse_y, obj_inspectable, false, true, _ds, true) > 0) {
	target = _ds[| 0]
	for (var i = 1; i < ds_list_size(_ds); i++) {
		if (_ds[| i].depth < target.depth) {
			target = _ds[| i]
		}
	}
}
ds_list_destroy(_ds)


if (target != noone) {
	target.update_data(true)
	
	data[0] = string(target.x)
	data[1] = string(target.y)
	
	data[2] = ""
	var _names = variable_struct_get_names(target.inspector_struct)
	var _s;
	for (var i = 0; i < array_length(_names); i++) {
		_s = variable_struct_get(target.inspector_struct, _names[i])
		if (typeof(_s) == "array") {
			data[2] += _names[i] + " : [\n"
			for (var o = 0; o < array_length(_s); o++) {
				data[2] += string(o) + ": " + string(_s[o]) + "\n"
			}
			data[2] += "]\n"
		} else {
			data[2] += _names[i] + " : " + string(_s) + "\n"
		}
	}
}

draw_set_colour(c_black)
draw_set_alpha(0.5)
draw_rectangle(x - width, y, x + width, y + 32*(array_length(data) - 1) + string_height(data[2]), false);

draw_set_halign(fa_center)
draw_set_colour(c_white)
draw_set_alpha(1)
for (var i = 0; i < array_length(data); i++) {
	draw_text(x, y + 32*i, data[i]);
}