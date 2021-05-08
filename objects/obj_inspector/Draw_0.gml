
if (target != noone && instance_exists(target)) {
	target.update_data(false)
}

target = collision_point(mouse_x, mouse_y, obj_inspectable, false, true)

if (target != noone) {
	target.update_data(true)
	
	data[0] = string(target.x)
	data[1] = string(target.y)
	data[2] = target.inspector_struct
	
	data[2] = string_replace_all(data[2], ",", "\n")
	//data[2] = string_replace_all(data[2], "{", "`")
	//data[2] = string_replace_all(data[2], "}", "`")
	
	data[2] = ""
	var _names = variable_struct_get_names(target.inspector_struct)
	for (var i = 0; i < array_length(_names); i++) {
		data[2] += _names[i] + " : " + string(variable_struct_get(target.inspector_struct, _names[i])) + "\n"
	}
	data[2] = string_replace_all(data[2], "},", "\n")
	
	//// remove functions
	//var i = 0;
	//while (string_last_pos("gml_Script", data[2]) != 0 and i < 10) {
	//	i++;
	//	var _pos = string_last_pos("gml_Script", data[2]);
	//	data[2] = string_delete(
	//		data[2],
	//		string_last_pos_ext("`", data[2], _pos),
	//		string_pos_ext("`", data[2], _pos) - string_last_pos_ext("`", data[2], _pos)
	//	)
	//}
	
	//data[2] = string_replace_all(data[2], "`", "\n")
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