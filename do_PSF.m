exposure = 100;
roi = [748, 540, 224, 309];
mir = -0.83;
etl3_center = 5.23;
deviation = 0.5;
step_size = 0.01;
wavelength = 561;
intensity = 6;
path = strcat('F:/Joe/volume_scan/', date);
file = 'membrane_psf_561_endpoint.tif';

init_ni();
init_cam(exposure, roi);
get_PSF(mir, etl3_center, deviation, step_size, wavelength, intensity, path, file);
global ni;
global cam;