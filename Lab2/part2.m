%% Model estimation - 2D Case
clear all; clc; close all;
rng(5);
S = load('lab2_2.mat');

% data - a two-column matrix; each row [x y] defines one point
al = S.al;
bl = S.bl;
cl = S.cl;

minxy= min([al; bl; cl]);
maxxy = max([al; bl; cl]);

%% Parametric estimation
% sample mean & covariance
[mu_al, covar_al] = gaussian2d(al);
[mu_bl, covar_bl] = gaussian2d(bl);
[mu_cl, covar_cl] = gaussian2d(cl);

x = minxy(1):maxxy(1);
y = minxy(2):maxxy(2);
[X, Y] = meshgrid(x, y);
 
grid_points = [X(:), Y(:)];

probs_al = mvnpdf(grid_points, mu_al, covar_al);
probs_bl = mvnpdf(grid_points, mu_bl, covar_bl);
probs_cl = mvnpdf(grid_points, mu_cl, covar_cl);

probs_all = cat(2, probs_al, probs_bl, probs_cl);
[~, class_idx] = max(probs_all, [], 2);

a_mask = (class_idx == 1);
b_mask = (class_idx == 2);
c_mask = (class_idx == 3);
colors = zeros(size(class_idx, 1), 3);
% class a color = red
colors(a_mask, 1) = 1;
colors(a_mask, 2) = 0.5;
colors(a_mask, 3) = 0.5;
% class b color = green
colors(b_mask, 1) = 0.5;
colors(b_mask, 2) = 1;
colors(b_mask, 3) = 0.5;
% class c color = gray
colors(c_mask, 1) = 0.5;
colors(c_mask, 2) = 0.5;
colors(c_mask, 3) = 0.5;

% Decision boundary
figure(1);
hold on;
scatter(grid_points(:, 1), grid_points(:, 2), 3, colors, 'filled');
hold on;
% Cluster data
scatter(al(:, 1), al(:, 2),20, 'blue', "+");
hold on;
scatter(bl(:, 1), bl(:, 2), 50, 'black', "s", 'filled');
hold on;
scatter(cl(:, 1), cl(:, 2), 20, 'cyan', "o", 'filled');

title('Parametric Estimation Classification Boundaries')
legend('Boundary','al','bl','cl')

hold off;

%% Non-parametric estimation

space = 1;
bandwith = 200;
[win_x, win_y] = meshgrid(-bandwith:space:bandwith);
win_range = [win_x(:) win_y(:)];

win_mu = [0 0];
win_covar = [400 0; 0 400];
win = mvnpdf(win_range, win_mu, win_covar);
win = reshape(win, size(win_x, 1), size(win_x, 2));

% res - a vector of five values  [res lowx lowy highx highy]
% determines the spatial step between PDF estimates
res = [space minxy maxxy];

% x - estimated locations along x-axis; this is just  [lowx:res(1):highx]
% y - estimated locations along y-axis; this is just  [lowy:res(1):highy]
% p - estimated 2D PDF, a matrix of values
[p_al,x_al,y_al] = parzen( al, res, win );
[p_bl,x_bl,y_bl] = parzen( bl, res, win );   
[p_cl,x_cl,y_cl] = parzen( cl, res, win );  

x_al = x_al';
x_bl = x_bl';
x_cl = x_cl';
y_al = y_al';
y_bl = y_bl';
y_cl = y_cl';
 
x2 = min([x_al; x_bl; x_cl]):max([x_al; x_bl; x_cl]);
y2 = min([y_al; y_bl; y_cl]):max([y_al; y_bl; y_cl]);

[X2,Y2] = meshgrid(x2, y2);
grid_points2 = [X2(:), Y2(:)];

p_all = cat(2, p_al(:), p_bl(:), p_cl(:));
[~, class_idx] = max(p_all, [], 2);

a_mask = (class_idx == 1);
b_mask = (class_idx == 2);
c_mask = (class_idx == 3);
colors = zeros(size(class_idx, 1), 3);
% class a color = red
colors(a_mask, 1) = 1;
colors(a_mask, 2) = 0.5;
colors(a_mask, 3) = 0.5;
% class b color = green
colors(b_mask, 1) = 0.5;
colors(b_mask, 2) = 1;
colors(b_mask, 3) = 0.5;
% class c color = gray
colors(c_mask, 1) = 0.5;
colors(c_mask, 2) = 0.5;
colors(c_mask, 3) = 0.5;

% Decision boundary
figure(2);
hold on;
scatter(grid_points2(:, 1), grid_points2(:, 2), 3, colors, 'filled');
hold on;
% Cluster data
scatter(al(:, 1), al(:, 2),20, 'blue', "+");
hold on;
scatter(bl(:, 1), bl(:, 2), 50, 'black', "s", 'filled');
hold on;
scatter(cl(:, 1), cl(:, 2), 20, 'cyan', "o", 'filled');

title('Non-parametric Estimation Classification Boundaries')
legend('Boundary','al','bl','cl')

hold off;

figure(3);
heatmap(win);
