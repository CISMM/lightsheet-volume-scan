global ni;
global cam;
global is_primary;
global is_secondary;
global is_primary_v;
global is_secondary_v;

ni = NI();
ni.start();
cam = videoinput('hamamatsu', 1, 'MONO16_2048x2048_FastMode');
cam.FramesPerTrigger = 1;
src = getselectedsource(cam);

%% Parameters for initialization scan
save_path = fullfile('F:/Joe/volume_scan', datestr(now, 'yyyy-mm-dd_HH-MM'));
is_primary = 561;
is_secondary = 488;
is_primary_v = 6;
is_secondary_v = 3;

mir_start = -0.867;
mir_end = 1.225;
etl3_start = 5.06;
etl3_end = 4.29;
autofocus_diviation = 0.5;
autofocus_steps = 3;
src.ExposureTime = 0.02;
num_sample = 10;
num_scan = 50;
cam.ROIPosition = [671, 849, 243, 430];

%% Parameters for fast volume scan
readout = 10;
exposure = 50;
volumetric_scan_intensity_488 = 6;
volumetric_scan_intensity_561 = 8;
output_path = 'C:/Users/efn/Desktop/volumetric_launcher';

%% Start of experiment
[mir_arr, etl_arr] = initialization_scan(mir_start, mir_end, etl3_start ...
    ,etl3_end, num_sample, num_scan, autofocus_diviation, autofocus_steps,save_path, 'init');

volume_scan_parameters = create_volume_scan_input( ...
mir_arr, etl3_arr, readout, exposure ...
,volumetric_scan_intensity_488, volumetric_scan_intensity_561);

serialize_volume_scan_parameter(volume_scan_parameters, output_path);

% Use the lookup table to slow scan a single volume (for debug or preview)
% ------------------------------------------------------------------------
% disp('Primary volume scan...');
% imgs = matlab_volume_scan(mir_arr, etl_arr, is_primary, is_primary_v);
% save_to_disk(imgs, save_path, 'primary_volume.tif');
% 
% disp('Secondary volume scan...');
% imgs = matlab_volume_scan(mir_arr, etl_arr, is_secondary, is_secondary_v);
% save_to_disk(imgs, save_path, 'secondary_volume.tif');
