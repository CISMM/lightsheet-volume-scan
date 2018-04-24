exposure = 100;
roi = [846, 933, 190, 190];
mir = 2;
etl3_center = 5.5;
deviation = 0.5;
step_size = 0.01;
wavelength = 561;
intensity = 3;
path = strcat('F:/Joe/volume_scan/', date);
file = 'membrane_psf_561.tif';

init_ni();
init_cam(exposure, roi);
get_PSF(mir, etl3_center, deviation, step_size, wavelength, intensity, path, file);
global ni;
global cam;