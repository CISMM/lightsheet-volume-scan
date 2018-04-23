function init_cam()
global cam;
global src;
cam = videoinput('hamamatsu', 1, 'MONO16_2048x2048_FastMode');
cam.FramesPerTrigger = 1;
src = getselectedsource(cam);
end

