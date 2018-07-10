function do_continuous_fast_scan(scan_program, lookup_table, num_volumes)
%global cam;


cam = videoinput('hamamatsu', 1, 'MONO16_2048x2048_FastMode');
cam.FramesPerTrigger = 3;
%src = getselectedsource(cam);
%src.ExposureTime = 0.01;

%% Open LabView program
system([scan_program, ' ', lookup_table, ' &']);

%% Setup camera
frames_expected = 0;
%set_camera_mode('continuous_fast_scan');
triggerconfig(cam, 'hardware', 'HighLevel', 'LevelTrigger');
cam.TriggerRepeat = frames_expected;

preview(cam);
start(cam);


%% Generate a pulse to start the scanning
gen_pulse();

%% Stop when we get enough volume data
%wait(cam);

cam.FramesAcquired
while cam.FramesAcquired < 4
    pause(1)
end

fprintf("after wait\n");
stoppreview(cam);
stop(cam);

    
%% Save video frames to disk
[data,~,~] = getdata(cam);
[h, w, b, f] = size(data)
%% kill the fast scan program
[~,name,ext] = fileparts(scan_program);
dos(['taskkill /im', ' ', name, ext]);
end

