function imgs = get_PSF(center, deviation, step_size, wavelength, intensity ...
    , exposure, path, file)
init_ni();
init_cam();

global ni;
global cam;
global src;
switch wavelength
    case 488
        set_laser = @ni.set_488;
    case 561
        set_laser = @ni.set_561;
end
src.ExposureTime = exposure / 1000;

first = center - (deviation / 2);
last  = center + (deviation / 2);
num_imgs = ceil(deviation/step_size);
ticks = linspace(first, last, num_imgs);

imgs = cell(length(ticks));
for i = 1:num_imgs
    ni.set_etl3(ticks(i));
    set_laser(intensity);
    imgs{i} = getsnapshot(cam);
    set_laser(0);
end

save_to_disk(imgs, path, file);
end

