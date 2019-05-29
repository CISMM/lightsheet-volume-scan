global ni;
global cam;
global is_primary;
global is_secondary;
global is_primary_v;
global is_secondary_v;
global extra_pts_mir_start;
global extra_pts_mir_end;

ni = NI();
ni.start();
cam = videoinput('hamamatsu', 1, 'MONO16_2048x2048_FastMode');
cam.FramesPerTrigger = 1;
src = getselectedsource(cam);

%% Parameters for initialization scan
%save_path = fullfile('C:\Users\megkern\Documents\volume_scans\', datestr(now, 'yyyy-mm-dd_HH-MM'));
%save_path = fullfile('G:\Evan N 2019\190322 3d', datestr(now, 'yyyy-mm-dd_HH-MM'));
save_path = fullfile('G:\hobsonc\volume_scan', datestr(now, 'yyyy-mm-dd_HH-MM'));
is_primary = 561; %Your primary laser
is_secondary = 488;
is_primary_v = 1.0;
is_secondary_v = 0;
extra_pts_mir_start = 15;
extra_pts_mir_end = 15;%How many extra points beyond mirror start and mirror end do
%you want? This adds same number to each side. 
%e.g., For extra_pts=2, 2 extra points to the left are added and 2 points
%to the right are added.

mir_start = 0.68;%mirror_start should be smaller than mirror_end
mir_end = 1.99;
etl3_start = 4.62;
etl3_end = 4.19;
autofocus_diviation = 0.5;%ETL3 voltage range
autofocus_steps = 20;%points in each microscan
src.ExposureTime = 0.02;%in seconds
num_sample = 4;%how many microscans
num_scan = 54;%how many frames volume scan ends up being, not including extras. num_scan or #step = abs((mir_start-mir_end))*10.2/0.2
cam.ROIPosition = [844, 580, 364, 248];%region of interest you defined in HCImage Live [x0,y0,width, height]

%% Parameters for fast volume scan
readout = 5;
exposure = 5;
delay = 100; %% Time in ms inbetween each volume for timelapse volumetic imaging
volumetric_scan_intensity_488 = 2.0; %Laser1
volumetric_scan_intensity_561 = 2.0; %Laser2
%output_path = 'C:\Users\megkern\Documents\volume_scans\04302019';
output_path = 'C:/Users/hobsonc/Desktop/LabView_bin/lookup_tables';
%output_path ='C:/Users/efn/Desktop/LabView_programs';

%% Start of experiment
% [mir_arr, etl_arr] = initialization_scan(mir_start, mir_end, etl3_start ...
%     ,etl3_end, num_sample, num_scan, autofocus_diviation, autofocus_steps,save_path, 'init');

[mir_arr, etl_arr] = initialization_scan_extra(mir_start, mir_end, etl3_start ...
    ,etl3_end, num_sample, num_scan, autofocus_diviation, autofocus_steps,save_path, 'init');

% plot(mir_arr, etl_arr);

volume_scan_parameters = create_volume_scan_input( ...
mir_arr, etl_arr, readout, exposure ...
,volumetric_scan_intensity_488, volumetric_scan_intensity_561, delay);

serialize_volume_scan_parameter(volume_scan_parameters, output_path);

% Use the lookup table to slow scan a single volume (for debug or preview)
% ------------------------------------------------------------------------
% disp('Primary volume scan...');
% imgs = matlab_volume_scan(mir_arr, etl_arr, is_primary, is_primary_v);
% save_to_disk(imgs, save_path, 'primary_volume.tif');
% % volume_scan_parameters{1,6}=volume_scan_parameters{1,6}+0.0727;
% % volume_scan_parameters{1,5}=volume_scan_parameters{1,5}+0.0727;
% disp('Secondary volume scan...');
% imgs = matlab_volume_scan(mir_arr, etl_arr, is_secondary, is_secondary_v);
% save_to_disk(imgs, save_path, 'secondary_volume.tif');
