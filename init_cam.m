function init_cam(exposure, roi)
global cam;
global src;
cam = videoinput('hamamatsu', 1, 'MONO16_2048x2048_FastMode');
cam.FramesPerTrigger = 1;
cam.ROIPosition = roi;
src = getselectedsource(cam);
src.ExposureTime = exposure / 1000;
end

