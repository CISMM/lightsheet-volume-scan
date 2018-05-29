function [success, peak_in_x, peak_in_y, f] = peak_in_fit(fitting, xarr, yarr, path, file)
% Fit the curve created by 'xarr' and 'yarr' with 'fitting'.
% Return value is x location where the y peaks. The precision is 0.01.
    try
        f = fit(xarr', yarr', fitting);
        x_space = 0.01;
        num_x = (xarr(end) - xarr(1)) / x_space;
        new_x = linspace(xarr(1), xarr(end), abs(num_x)+1);
        [peak_in_y, locs] = findpeaks(f(new_x));
        plot(f, xarr, yarr);
        if ~isempty(path)
            if ~exist(path, 'dir')
                mkdir(path);
            end
            saveas(gcf, fullfile(path, file));
        end
        
        if ~isempty(locs)
            peak_in_x = new_x(locs(1));       
            success = true;
        else
            % Fitting can go wrong without throwing any exception, and the
            % returned peak location is empty.
            % E.g. x:[1,2,3,4,5] y:[4,4,3,3,3] for 'gauss1'
            peak_in_x = NaN;
            success = false;
        end
    % Exception is thrown if fitting fails.
    % E.g. x:[1,2,3,4,5], y:[4,4,3,3,3] for 'gauss1'
    catch
        plot(f, xarr, yarr);
        if ~isempty(path)
            if ~exist(path, 'dir')
                mkdir(path);
            end
            saveas(gcf, fullfile(path, file));
        end
        peak_in_x = NaN;
        success = false;
    end
end

