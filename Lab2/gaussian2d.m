function [ mu, covar ] = gaussian2d( x )
    mu = sum(x) / length(x);
    covar = cov(x);
end

