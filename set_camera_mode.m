function set_camera_mode(mode)
global cam;

switch mode
    case 'continuous_fast_scan'
        fprintf("continuous_fast_scan\n");
        triggerconfig(cam, 'hardware', 'HighLevel', 'LevelTrigger');
        
    case 'afm_fast_scan'
        triggerconfig(cam, 'hardware', 'HighLevel', 'LevelTrigger');
    otherwise
        fprintf("Unknown camera mode. Roll back to interl mode.");
        triggerconfig(cam, 'immediate');
end
        
end

