function serialize_volume_scan_parameter( ...
    parameter_arr,dir)
file_name = datestr(now,'yyyy-mm-dd_HH-MM');
dlwrite(fullfile(dir, file_name), parameter_arr);
end

