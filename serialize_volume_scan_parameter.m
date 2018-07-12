function lookup_table_file = serialize_volume_scan_parameter( ...
    parameter_cell,dir)
%file_name = datestr(now,'yyyy-mm-dd_HH-MM');
%dlmwrite(fullfile(dir, file_name), parameter_arr, 'delimiter', ' ');

if ~exist(out_dir, 'dir')
    mkdir(out_dir);
end

file_name = datestr(now,'yyyy-mm-dd_HH-MM');
fileID = fopen(fullfile(dir, file_name),'w');
fprintf(fileID,'%s\n',parameter_cell{1});
fclose(fileID);

lookup_table_file = fullfile(dir, file_name);

for n = 2:numel(parameter_cell)
    dlmwrite(lookup_table_file, parameter_cell{1,n}, '-append', 'delimiter', ' ');
end


end
