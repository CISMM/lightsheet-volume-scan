function set_camera_mode(mode)
global cam;

switch mode
    case 'fast_scan'
        fprintf('Set camera to External Level Trigger mode\n');
        triggerconfig(cam, 'hardware', 'HighLevel', 'LevelTrigger');
    otherwise
        fprintf("Unknown camera mode. Roll back to internal mode.");
        triggerconfig(cam, 'immediate');
end
        
end

