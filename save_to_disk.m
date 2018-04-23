function save_to_disk(imgs,path, f_name)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
if ~strcmp(path, '')
    if ~strcmp(path(end), '/')
        path = strcat(path, '/');
    end
    if ~exist(path, 'dir')
        mkdir(path);
    end
    for i=1:size(imgs)
        if i == 1
            imwrite(imgs{i}, strcat(path, f_name));
        else
            imwrite(imgs{i}, strcat(path, f_name), 'WriteMode','append');
        end
    end
end
end

