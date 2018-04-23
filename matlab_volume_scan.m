function imgs = matlab_volume_scan(mir_arr, etl_arr, wavelength, volt)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
if length(mir_arr) ~= length(etl_arr)
    disp('mirror array has different size than etl array.');
    return;
end

global ni;
global cam;

switch wavelength
    case 488
        set_laser = @ni.set_488;
    case 561
        set_laser = @ni.set_561;
end

num_img = length(mir_arr);
imgs = cell(num_img);

for i = 1:num_img
    ni.set_mir(mir_arr(i));
    ni.set_etl3(etl_arr(i));
    set_laser(volt);
    imgs{i} = getsnapshot(cam);
    set_laser(0);
end

