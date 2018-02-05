function class = getMAPClass(pos, mu_X, cov_X, P_X, mu_Y, cov_Y, P_Y)
    decision =  2*log(P_Y/P_X)+log(det(cov_X)/det(cov_Y));
    value = ((pos - mu_Y)*inv(cov_Y))*transpose(pos - mu_Y) - ((pos - mu_X)*inv(cov_X))*transpose(pos - mu_X);
    if value > decision
        class = 1;
    elseif value < decision
        class = 2;
    else
        class = 0;
    end
end
