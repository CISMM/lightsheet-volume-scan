function do_fast_scan(scan_program, lookup_table, num_ims, out_dir)
global cam;

%cam = videoinput('hamamatsu', 1, 'MONO16_2048x2048_FastMode');

% This is how many frames to expect before stop
cam.FramesPerTrigger = num_ims;
if num_ims == 0
    cam.FramesPerTrigger = Inf;

%% Open LabView program
system([scan_program, ' ', lookup_table, ' &']);

%% Setup camera
set_camera_mode('continuous_fast_scan');
start(cam);

%% Generate a pulse to start the scanning
gen_pulse();

%% Stop when we get enough volume data
wait(cam);

%% Save video frames to disk
[data,~,~] = getdata(cam);
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

