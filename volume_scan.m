% Get the camera
% cam = videoinput('hamamatsu', 1, 'MONO16_2048x2048_FastMode');
% src = getselectedsource(cam);
% cam.FramesPerTrigger = 1;


% for i = 1:1
%    imgs{i} = getsnapshot(cam); 
% end
%save_arr_to_disk(imgs, 'abc.tif');

% img = imread('C:\Program Files\Micro-Manager-1.4\test\\Pos0\img_000000000_Default0_000.tif');
% 
% img = [102, 101, 107, 105; 100, 105, 100, 100; 102, 109, 100, 101; 107, 109, 113, 103];
% img
% tenengrad(img)
% 
% imshow(img)

% a = [1, 2, 3, 4, 5];
% b = [1, 3, 10, 8, 6];
% 
% x = peak_in_gaussian(a, b);
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
save_path = strcat('F:/Joe/volume_scan/', date, '/');
is_primary = 561;
is_secondary = 488;
is_primary_v = 6;
is_secondary_v = 3;

mir_start = -0.967;
mir_end = 1.225;
etl3_start = 5.06;
etl3_end = 4.29;
autofocus_diviation = 0.3;
autofocus_steps = 20;
src.ExposureTime = 0.1;
num_sample = 10;
num_scan = 50;
cam.ROIPosition = [671, 849, 243, 430];

[mir_arr, etl_arr] = initialization_scan(mir_start, mir_end, etl3_start ...
    ,etl3_end, num_sample, num_scan, autofocus_diviation, autofocus_steps,save_path, 'init');
disp('Primary volume scan...');
imgs = matlab_volume_scan(mir_arr, etl_arr, is_primary, is_primary_v);
save_to_disk(imgs, save_path, 'primary_volume.tif');

disp('Secondary volume scan...');
imgs = matlab_volume_scan(mir_arr, etl_arr, is_secondary, is_secondary_v);
save_to_disk(imgs, save_path, 'secondary_volume.tif');
