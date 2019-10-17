function [medium_1, medium_2, medium_3] = getMaterialStruct( ...
						arg_list_med_1, arg_list_med_2, arg_list_med_3)
	
	% Für Medium 1
	material_list = arg_list_med_1;	
	material_list_2 = substr(material_list, 2, length(material_list)-2);
	material_cell_array = strread(material_list_2, "%s", 'delimiter', ']');
	[datensaetze_cnt, n] = size(material_cell_array);
	material_cell_array{1,1} = substr(material_cell_array{1,1}, 2);
	for i = 2:datensaetze_cnt
		material_cell_array{i,1} = substr(material_cell_array{i,1}, 3);
	endfor
		
	for i = 1:datensaetze_cnt
		[medium_1(i).ID, medium_1(i).Kategorie, medium_1(i).Materialname, medium_1(i).eps_r_fmin, medium_1(i).eps_r_Fkt_Typ, medium_1(i).eps_r_fmax, medium_1(i).eps_r_a, medium_1(i).eps_r_b, medium_1(i).eps_r_c, medium_1(i).kappa_fmin, medium_1(i).kappa_Fkt_Typ, medium_1(i).kappa_fmax, medium_1(i).kappa_a, medium_1(i).kappa_b, medium_1(i).kappa_c, medium_1(i).my_r_fmin, medium_1(i).my_r_Fkt_Typ, medium_1(i).my_r_fmax, medium_1(i).my_r_a, medium_1(i).my_r_b, medium_1(i).my_r_c, medium_1(i).f_min, medium_1(i).f_max] = strread(material_cell_array{i, 1}, "%d %s %s %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f", 'delimiter', ';');
	endfor

	%Für Medium 2
	material_list = arg_list_med_2;	
	material_list_2 = substr(material_list, 2, length(material_list)-2);
	material_cell_array = strread(material_list_2, "%s", 'delimiter', ']');
	[datensaetze_cnt, n] = size(material_cell_array);
	material_cell_array{1,1} = substr(material_cell_array{1,1}, 2);
	for i = 2:datensaetze_cnt
		material_cell_array{i,1} = substr(material_cell_array{i,1}, 3);
	endfor
		
	for i = 1:datensaetze_cnt
		[medium_2(i).ID, medium_2(i).Kategorie, medium_2(i).Materialname, medium_2(i).eps_r_fmin, medium_2(i).eps_r_Fkt_Typ, medium_2(i).eps_r_fmax, medium_2(i).eps_r_a, medium_2(i).eps_r_b, medium_2(i).eps_r_c, medium_2(i).kappa_fmin, medium_2(i).kappa_Fkt_Typ, medium_2(i).kappa_fmax, medium_2(i).kappa_a, medium_2(i).kappa_b, medium_2(i).kappa_c, medium_2(i).my_r_fmin, medium_2(i).my_r_Fkt_Typ, medium_2(i).my_r_fmax, medium_2(i).my_r_a, medium_2(i).my_r_b, medium_2(i).my_r_c, medium_2(i).f_min, medium_2(i).f_max] = strread(material_cell_array{i, 1}, "%d %s %s %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f", 'delimiter', ';');
	endfor
	
	%Für Medium 3
	material_list = arg_list_med_3;	
	material_list_2 = substr(material_list, 2, length(material_list)-2);
	material_cell_array = strread(material_list_2, "%s", 'delimiter', ']');
	[datensaetze_cnt, n] = size(material_cell_array);
	material_cell_array{1,1} = substr(material_cell_array{1,1}, 2);
	for i = 2:datensaetze_cnt
		material_cell_array{i,1} = substr(material_cell_array{i,1}, 3);
	endfor
		
	for i = 1:datensaetze_cnt
		[medium_3(i).ID, medium_3(i).Kategorie, medium_3(i).Materialname, medium_3(i).eps_r_fmin, medium_3(i).eps_r_Fkt_Typ, medium_3(i).eps_r_fmax, medium_3(i).eps_r_a, medium_3(i).eps_r_b, medium_3(i).eps_r_c, medium_3(i).kappa_fmin, medium_3(i).kappa_Fkt_Typ, medium_3(i).kappa_fmax, medium_3(i).kappa_a, medium_3(i).kappa_b, medium_3(i).kappa_c, medium_3(i).my_r_fmin, medium_3(i).my_r_Fkt_Typ, medium_3(i).my_r_fmax, medium_3(i).my_r_a, medium_3(i).my_r_b, medium_3(i).my_r_c, medium_3(i).f_min, medium_3(i).f_max] = strread(material_cell_array{i, 1}, "%d %s %s %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f", 'delimiter', ';');
	endfor
	
endfunction
