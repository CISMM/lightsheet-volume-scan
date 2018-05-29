function [scan_x_arr, scan_y_arr] = initialization_scan(mir_start, mir_end, etl_start ...
                                      ,etl_end, num_sample, num_scan ...
                                      ,autofocus_diviation, autofocus_steps...
                                      ,save_path, file_prefix)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
global ni;
global is_primary;
global is_primary_v;

if num_sample < 2
    %out_str = 'Number of sample must be > 2.';
    return
end

%best_f = autofocus(4.76, 0.3, 4, 561, 1, strcat('F:/Joe/volume_scan/', date), 'auto.tif');
sample_x_arr = linspace(mir_start, mir_end, num_sample);
sample_y_arr = zeros(1, num_sample);
scan_x_arr = linspace(mir_start, mir_end, num_scan);
scan_y_arr = zeros(1, num_scan);

disp('Computing sample points...');
% Autofocus on both end, and populate center_arr.
ni.set_mir(sample_x_arr(1));
sample_y_arr(1) = autofocus(etl_start, autofocus_diviation, autofocus_steps ...
    , is_primary, is_primary_v, save_path, strcat(file_prefix, '-1.tif'));
ni.set_mir(sample_x_arr(end));
sample_y_arr(end) = autofocus(etl_end, autofocus_diviation, autofocus_steps ...
    , is_primary, is_primary_v, save_path, strcat(file_prefix,'-',int2str(num_sample),'.tif'));
center_arr = linspace(sample_y_arr(1), sample_y_arr(end), num_sample);

% Autofocus on each sample point, using center_arr as center.
for i=2:num_sample-1
    sample_y_arr(i) = autofocus(center_arr(i), autofocus_diviation+0.6, autofocus_steps ...
    ,is_primary, is_primary_v, save_path, strcat(file_prefix,'-',int2str(i),'.tif'));
end

disp('Computing scan points...');
% Determine scan x values lies in which sample interval, and interpolate
% the y value.
sample_interval = (mir_end - mir_start) / (num_sample-1);
for i = 1:num_scan
    quotient = fix((scan_x_arr(i) - sample_x_arr(1)) / sample_interval); 
    if quotient < 0
        quotient = 0;
    elseif quotient >= num_sample-1
        quotient = num_sample-2;
    end
    scan_y_arr(i) = interp1(sample_x_arr(quotient+1:quotient+2) ...
        ,sample_y_arr(quotient+1:quotient+2), scan_x_arr(i) ...
        ,'linear', 'extrap');
    fprintf("x:%.2f  y:%.2f interpX:%.2f, interpY:%.2f\n" ...
        ,sample_x_arr(quotient+1:quotient+2) ...
        ,sample_y_arr(quotient+1:quotient+2) ...
        ,scan_x_arr(i) ...
        ,scan_y_arr(i))
end
end

