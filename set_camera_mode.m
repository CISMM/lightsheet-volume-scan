function set_camera_mode(mode)
global cam;

switch mode
    case 'continuous_fast_scan'
    case 'afm_fast_scan'
        triggerconfig(cam, 'hardware', 'RisingEdge', 'EdgeTrigger');
        cam.TriggerRepeat = 0;
    otherwise
        fprintf("Unknown camera mode. Roll back to interl mode.");
        triggerconfig(cam, 'immediate');
end
        
end

