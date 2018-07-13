function do_afm_fast_scan(scan_program, lookup_table, num_ims, out_dir)
global cam;

cam.FramesPerTrigger = 1;

%% Open LabView program
system([scan_program, ' ', lookup_table, ' &']);

%% Setup camera
set_camera_mode('fast_scan');

if num_ims == 0
    cam.TriggerRepeat = Inf;
else
    cam.TriggerRepeat = num_ims - 1;
end

start(cam);
fprintf('Camera is ready\n');

%% Wait until TriggerRepeat reaches the target
wait(cam, 60);
fprintf('Camera is stopped\n');

%% Save video frames to disk
[data,~,~] = getdata(cam, num_ims);
base = 'volume_scan';
[~,~,~,N] = size(data);
if ~exist(out_dir, 'dir')
    mkdir(out_dir);
end
for i = 1:N
    im = data(:,:,1,i);
    name = strcat(base, sprintf('%05d', i), '.tiff');
    imwrite(im, fullfile(out_dir, name));
end

%% kill the fast scan program
[~,name,ext] = fileparts(scan_program);
dos(['taskkill /im', ' ', name, ext]);
end

