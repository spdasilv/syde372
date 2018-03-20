function [ mu, var ] = gaussian( x )
    mu = mean(x);
    var = (sum((x - mu).^2))/length(x);
end

