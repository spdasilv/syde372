function [ p_x, range ] = parzen_gaussian( x, h, offset )
    min_x = min(x)-offset;
    max_x = max(x)+offset;
    dt = 0.01;
    range = min_x:dt:max_x;
    sum_phi = 0;
    p_x = zeros(length(range),1);

    for i=1:length(range)
        xi = range(i);
        for j = 1:length(x)
            xj = x(j);
            sum_phi = sum_phi + gaussian_fx( h, (xi-xj) );
        end
        p_x(i) = sum_phi/length(x);
        sum_phi = 0;
    end
end

