%%
clc; clear all; close all;
%% Lab 3 - Read
cloth_im = readim('cloth.im');
imagesc(cloth_im) ;
colormap(gray) ;
fts = load('feat.mat');
%%
pts = fts.f32;
figure;
aplot(pts)
%% Extract Data - for visualization
% [f1, f2, image, block]
im1 = pts(1:2, 1:16);
im2 = pts(1:2, 17:32);

figure;
plot(im1(1,:), im1(2,:), '*r');
hold on;
plot(im2(1,:), im2(2,:), '*b');
% Use iteration now
%% Run K-mean
K = 10;
data = pts(1:2,:)';

final = RunKMeans( data, K );
fx = final';

figure;
aplot(pts)
hold on;
plot(fx(1,:), fx(2,:), '*r')
hold on;

%%
set(0,'DefaultAxesLineStyleOrder',{'+','o','*','.','x','s','d','p','h','^'});
figure
% hold all
for i=1:16:length(pts)
    im = pts(1:2, i:i+15);
    plot(im(1,:), im(2,:))
    index = floor(i/16) + 1;
    hold on;
end

hold on;
plot(fx(1,:), fx(2,:), '*r')

%%
% legend({'1','2','3','4','5','6','7','8','9','10',})


