%% This file is used to generate the NN and KNN plots on the same plot

% Please make sure you have exectured the NN and KNN Scripts before
% and they are available in your memory

figure;
contour(x_vector, y_vector, featureSpaceAB_KNN', 'LineColor', 'r')
hold on
contour(x_vector, y_vector, featureSpaceAB_NN', 'LineColor', 'g')
hold on
scatter(A(:,1), A(:,2), 'filled')
hold on;
scatter(B(:,1), B(:,2), 'filled')
hold on;
plot_ellipse(cov_A, mu_A);
hold on;
plot_ellipse(cov_B, mu_B);
hold on;
title('Plot for Class A and Class B')
legend('KNN Boundary','NN Boundary', 'Class A','Class B')
%%
figure;
contour(x_vector, y_vector, featureSpaceCDE_KNN', 'LineColor', 'r')
hold on
contour(x_vector, y_vector, featureSpaceCDE_NN', 'LineColor', 'g')
hold on
scatter(C(:,1), C(:,2), 'filled')
hold on;
scatter(D(:,1), D(:,2), 'filled')
hold on;
scatter(E(:,1), E(:,2), 'filled')
hold on;
plot_ellipse(cov_C, mu_C);
hold on;
plot_ellipse(cov_D, mu_D);
hold on;
plot_ellipse(cov_E, mu_E);
hold on;
title('Plot for Class C, Class D, Class E')
legend('KNN Boundary', 'NN Boundary', 'Class C','Class D', 'Class E')

