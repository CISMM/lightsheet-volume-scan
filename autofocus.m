function best_v = autofocus(center, diviation, num_sample ...
                            ,wavelength, laser_v, save_path, file_name)
% Measure image quality at each point where it is told to take an image.
% The data points are fitted with gaussian to find the peak.
% When fitting fails, e.g. when the curve is a one way slope, the algorithm
% would take more images and pad the data in the direction of higher trend 
% in the curve, until a peak is seen. I called it self-correction.
% Everytime it self-corrects, the data points are doubled.
                        
javaaddpath('./AutoPilot-1.0.jar');
import autopilot.interfaces.*;

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
imgs = cell(1, num_sample);
focus_arr = zeros(1, num_sample);

for i = 1:num_sample
    ni.set_etl3(etl_arr(i));
    set_laser(laser_v);
    imgs{i} = getsnapshot(cam);
    focus_arr(i) = AutoPilotM.dcts2(imgs{i},3);
    set_laser(0);
end
img_name = file_name(1:strfind(file_name, '.')-1);
%best_v = peak_in_gaussian(etl_arr, focus_arr, save_path, img_name);
[success, best_v] = peak_in_fit('gauss1', etl_arr, focus_arr, save_path, img_name);
pad_count = 1;
while ~success
    fprintf("self correct - center:%.2f - %d\", center, pad_count); 
    diff = etl_arr(2) - etl_arr(1);
    pad_size = numel(etl_arr);
    pad_imgs = cell(1, pad_size);
    pad_focus_arr = zeros(1, pad_size);
    if focus_arr(1) > focus_arr(end)
        new_end = etl_arr(1) - diff;
        new_start = new_end - (etl_arr(end) - etl_arr(1));
        pad_etl_arr = linspace(new_start, new_end, pad_size);
        for i = 1:pad_size
            ni.set_etl3(pad_etl_arr(i));
            set_laser(laser_v);
            pad_imgs{i} = getsnapshot(cam);
            pad_focus_arr(i) = AutoPilotM.dcts2(pad_imgs{i},3);
            set_laser(0);
        end
        etl_arr = horzcat(pad_etl_arr, etl_arr);
        focus_arr = horzcat(pad_focus_arr, focus_arr);
        imgs = horzcat(pad_imgs, imgs);
    elseif focus_arr(1) < focus_arr(end)
        new_start = etl_arr(end) + diff;
        new_end = new_start + (etl_arr(end) - etl_arr(1));
        pad_etl_arr = linspace(new_start, new_end, pad_size);
        for i = 1:pad_size
            ni.set_etl3(pad_etl_arr(i));
            set_laser(laser_v);
            pad_imgs{i} = getsnapshot(cam);
            pad_focus_arr(i) = AutoPilotM.dcts2(pad_imgs{i},3);
            set_laser(0);
        end
        etl_arr = horzcat(etl_arr, pad_etl_arr);
        focus_arr = horzcat(focus_arr, pad_focus_arr);
        imgs = horzcat(imgs, pad_imgs);
    else
        disp('Image qualities are all equal. There might be no signal.');
        return;
    end
    [success, best_v] = peak_in_fit('gauss1', etl_arr, focus_arr, save_path ...
        ,sprintf('%s-%d', img_name, pad_count));
    pad_count = pad_count + 1;
end

save_to_disk(imgs, save_path, file_name);
end

