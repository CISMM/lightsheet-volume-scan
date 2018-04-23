function [peak_in_x, peak_in_y] = peak_in_gaussian(xarr, yarr, path, file)
% Given x and y values, fit the curve with gaussian, and return the x where
% the y peaks. The precision of x is set to 0.01.
    try
        f = fit(xarr', yarr', 'gauss1');
        x_space = 0.01;
        num_x = (xarr(end) - xarr(1)) / x_space;
        new_x = linspace(xarr(1), xarr(end), abs(num_x)+1);
        [peak_in_y, locs] = findpeaks(f(new_x));
        if isempty(locs)
            [peak_in_y, ind] = max(yarr);
            peak_in_x = xarrx(ind);
        else
            peak_in_x = new_x(locs(1));
        end
    catch
        disp(strcat(file,'-Gaussian fitting failed. Use max value instead.'));
        f = fit(xarr', yarr', 'linear');
        [peak_in_y, ind] = max(yarr);
        yarr
        ind
        peak_in_x = xarr(ind);
    end
    
    plot(f, xarr, yarr);
    if ~isempty(path)
        saveas(gcf, strcat(path, file));
    end
end

