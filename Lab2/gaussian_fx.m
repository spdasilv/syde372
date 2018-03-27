function eval = gaussian_fx( sigma, x )
    % elem = (x-xi)/h;
    eval = exp(-0.5*(x/sigma)^2)/(sigma*sqrt(2*pi));
end

