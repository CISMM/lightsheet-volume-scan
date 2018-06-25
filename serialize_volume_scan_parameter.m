function serialize_volume_scan_parameter( ...
    parameter_cell,dir)
%file_name = datestr(now,'yyyy-mm-dd_HH-MM');
%dlmwrite(fullfile(dir, file_name), parameter_arr, 'delimiter', ' ');

file_name = datestr(now,'yyyy-mm-dd_HH-MM');
fileID = fopen(fullfile(dir, file_name),'w');
fprintf(fileID,'%s\n',parameter_cell{1});
fclose(fileID);

for n = 2:numel(parameter_cell)
    dlmwrite(fullfile(dir, file_name), parameter_cell{1,n}, '-append', 'delimiter', ' ');
end

end
