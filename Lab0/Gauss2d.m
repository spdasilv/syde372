function Y = Gauss2d( x1, x2, Mu, Sigma )
    Y = zeros( length(x1), length(x2) );
    for i=1:length(x1)
        for j=1:length(x2)
            v = [x1(i);x2(j)];
            Y(i,j) = 1/(2*pi*sqrt(det(Sigma)))*...
            exp(-0.5*(v-Mu)'*inv(Sigma)*(v-Mu));
        end
    end
end
