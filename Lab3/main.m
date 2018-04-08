%%
clc; clear all; close all;
%% Lab 3 - Read
cloth_im = readim('cloth.im');
imagesc(cloth_im) ;
colormap(gray) ;
fts = load('feat.mat');

%% Labelled Classification - MICD
f2 = fts.f2;
f2t = fts.f2t;
f8 = fts.f8;
f8t = fts.f8t;
f32 = fts.f32;
f32t = fts.f32t;

[accuracy2, cm2] = MICD(f2, f2t);
[accuracy8, cm8] = MICD(f8, f8t);
[accuracy32, cm32] = MICD(f32, f32t);

%% Image Classification & Segmentation
multf8 = fts.multf8;

cimage = MICD_p4(f8, multf8);

imagesc(fts.multim);
figure;

imagesc(cimage);
cmap = jet(10); % Assign colormap
colormap(cmap)
hold on
L = line(ones(10),ones(10), 'LineWidth',2); % Generate line 
set(L,{'color'},mat2cell(cmap,ones(1,10),3)); % Set the colors according to cmap
legend('Cloth','Cotton','Grass','Pigskin','Wood','Cork','Paper','Stone','Raiffa','Face')    
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

%% Unlabelled Clustering - Run K-mean
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


