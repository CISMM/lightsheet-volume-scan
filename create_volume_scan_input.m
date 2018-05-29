function out = create_volume_scan_input(...
    mir_arr, etl3_arr, readout, exposure, intensity_488, intensity_561)
% Say mir_arr:[1,2,3,4], etl3_arr:[5,6,7,8], readout:1, exposure:4,
% intensity_488:8, intensity_561:6
%
% The resulting array would be
% [1 4 3, 0 8 8 8 8, 0 0 0 0 0, 0 0 0 0 0, 0 6 6 6 6, 10 10 10 10 10 10 10 10 10 10,
% 4 3, -1 -2 -3 -4, 1 2 3 4, 5, 6, 7, 8] 
larger = max(readout, exposure);
smaller = min(readout, exposure);
if mod(larger, smaller) ~= 0
    disp('exposure has to be an INTEGER multiple of readout, or the other way around');
    return;
end

out_1 = [readout, exposure, 3];
ratio = larger / smaller;

if larger == readout
    out_2(1:ratio+1) = 0;
    out_2(end) = intensity_488;
    out_4(1:ratio+1) = 0;
    out_4(end) = intensity_561;
else
    out_2(1:ratio+1) = intensity_488;
    out_2(1) = 0;
    out_4(1:ratio+1) = intensity_561;
    out_4(1) = 0;
end
out_3 = zeros(1, (ratio+1)*2);
out_5(1:(ratio+1)*2) = 10;   % AOTF blanking. 

out_6 = [numel(mir_arr), 3];
out_7 = mir_arr .* -1;
out_8 = mir_arr;
out_9 = etl3_arr;

out = horzcat(out_1, out_2, out_3, out_4, out_5, out_6, out_7, out_8, out_9);
end

