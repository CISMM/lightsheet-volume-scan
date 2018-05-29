function save_to_disk(imgs,path, f_name)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
if ~strcmp(path, '')
    if ~exist(path, 'dir')
        mkdir(path);
    end
    for i=1:numel(imgs)
        if i == 1
            imwrite(imgs{i}, fullfile(path, f_name));
        else
            imwrite(imgs{i}, fullfile(path, f_name), 'WriteMode','append');
        end
    end
end
end

