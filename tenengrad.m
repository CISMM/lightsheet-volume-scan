function measure = tenengrad(img)
% Apply tenengrad algorithm to measure the focus of an image.
    ker1 = [-1, 0, 1;
            -2, 0, 2;
            -1, 0, 1];
    ker2 = [ 1,  2,  1; 
             0,  0,  0;
            -1, -2, -1];
    out1 = imfilter(img, ker1);
    out2 = imfilter(img, ker2);
    %measure = sumsqr(out1) + sumsqr(out2);
    measure = sumabs(out1) + sumabs(out2);
end

