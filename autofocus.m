function best_v = autofocus(center, diviation, num_sample ...
                            ,wavelength, laser_v, save_path, file_name)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

function imout = filter(im)
imout = imresize(imresize(im,0.333,'box'),3,'box');
end

global ni
global cam

switch wavelength
    case 488
        set_laser = @ni.set_488;
    case 561
        set_laser = @ni.set_561;
end

lower = center - diviation / 2;
upper = center + diviation / 2;
etl_arr = linspace(lower, upper, num_sample);
imgs = cell(num_sample);
focus_arr = zeros(1, num_sample);

% collect images and measures
for i = 1:num_sample
    ni.set_etl3(etl_arr(i));
    set_laser(laser_v);
    % take a snapshot
    imgs{i} = getsnapshot(cam);
    imgs{i} = filter(imgs{i});
    % measue focus
    focus_arr(i) = convolve_sobel(imgs{i});
    set_laser(0);
end
img_name = file_name(1:strfind(file_name, '.')-1);
best_v = peak_in_gaussian(etl_arr, focus_arr, save_path, img_name);
save_to_disk(imgs, save_path, file_name);
end

