mu_A = [5 10]';
mu_B = [10 15]';

sigma = [8 0; 0 4];
alpha = sqrt((mu_A - mu_B)'*inv(sigma)*(mu_A-mu_B));

dist = 1 - normcdf(alpha)
