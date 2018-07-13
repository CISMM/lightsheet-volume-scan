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
is_primary_v = 2;
is_secondary_v = 1;

mir_start = -1.935;
mir_end = -0.645;
etl3_start = 6.23;
etl3_end = 5.23;
autofocus_diviation = 0.5;              %ETL3 voltage range
autofocus_steps = 5;                    %points in each microscan
src.ExposureTime = 0.1;                 %in seconds
num_sample = 5;                         %how many microscans
num_scan = 50;                          %how many frames volume scan ends up being
cam.ROIPosition = [354, 933, 166, 319]; %region of interest you defined in HCImage Live [x0,y0,width, height]
lookup_table_output_path = 'C:/Users/efn/Desktop/LabView_bin/lookup_tables';

%% Parameters for fast volume scan
fast_readout = 2;
fast_exposure = 18;
fast_scan_intensity_488 = 6;
fast_scan_intensity_561 = 6;
afm_scan_program = 'C:\Users\phsiao\Desktop\AFM_sync_volumetric_scan.exe';
continuous_scan_program = 'C:\Users\phsiao\Desktop\continuous_volumetric_scan.exe';
fast_output_folder = fullfile(save_path, 'fast_scan');

%% Initialization scan
% [mir_arr, etl_arr] = initialization_scan(mir_start, mir_end, etl3_start ...
%     ,etl3_end, num_sample, num_scan, autofocus_diviation, autofocus_steps,save_path, 'init');
% 
% disp('Primary volume scan...');
% imgs = matlab_volume_scan(mir_arr, etl_arr, is_primary, is_primary_v);
% save_to_disk(imgs, save_path, 'primary_volume.tif');

%% Save lookup table to a text file
% fast_scan_parameters = create_volume_scan_input( ...
% mir_arr, etl_arr, fast_readout, fast_exposure ...
% ,fast_scan_intensity_488, fast_scan_intensity_561);
% 
% lookup_table_file = serialize_volume_scan_parameter(fast_scan_parameters, lookup_table_output_path);

%% Do slow volume scan  
% disp('Secondary volume scan...');
% imgs = matlab_volume_scan(mir_arr, etl_arr, is_secondary, is_secondary_v);
% save_to_disk(imgs, save_path, 'secondary_volume.tif');

%% Do fast volume scan

%%!!!!! MATLAB requires an extra trigger when camera is set to external level trigger mode !!!!! 
%%Need to find a workaround otherwise need to redesign the whole timing diagram.
lookup_table_file = 'C:\Users\phsiao\Desktop\lookup_table';
do_continuous_fast_scan(continuous_scan_program, lookup_table_file, 4, fast_output_folder);
%do_afm_fast_scan(afm_scan_program, lookup_table_file, 4, fast_output_folder);
delete(cam);