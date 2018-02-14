function pts =  plot_ellipse(cov, mean)
    % x,y,theta,a,b - centre (x,y), axis lengths a,b
    % major axis at an angle of theta radians from the horizontal
    np = 100;
    ang = [0:np]*2*pi/np;

    [V, D] = eig(cov);

    theta = atan(V(2,2)/V(1,2));
    a = sqrt(D(2,2));
    b = sqrt(D(1,1));

    x = mean(1); y = mean(2);

    pts = [x;y]*ones(size(ang)) + [cos(theta) -sin(theta); sin(theta) cos(theta)]*[cos(ang)*a; sin(ang)*b];
    plot( pts(1,:), pts(2,:), 'LineWidth', 3);
end
