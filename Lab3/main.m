%% Reset
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
%%
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

%% Unlabelled Clustering - Run K-mean
K = 10;
data = f32(1:2,:)';

final = RunKMeans( data, K );
fx = final';
% Plot Data
figure;
aplot(f32)
hold on;
plot(fx(1,:), fx(2,:), '*r')
hold on;
legend('Cluster centers')
%% Image Segmentation
figure;
imagesc(fts.multim) ;
colormap(gray) ;

% Begin Segmentation
seg_pts = fts.multf8;

[r,c,d] = size(seg_pts);

seg_data = zeros(r*c, d);
count = 1;

for i=1:r
    for j = 1:c
        seg_data(count,1) = seg_pts(i,j,1);
        seg_data(count,2) = seg_pts(i,j,2);
        count = count+1;
    end
end

prot_K = 10;
prototypes = RunKMeans( seg_data, prot_K );
result = clustering_segmentation(seg_pts, prototypes);

figure;
imagesc(result)

%% Show results
figure;
imagesc(result)
% colormap(cmap);

minA = min(result(:));
maxA = max(result(:));

legends = {'Cloth','Cotton','Grass','Pigskin','Wood', 'Cork','Paper'...
            'Stone','Raiffa', 'Face'};

hold on;
for K = minA : maxA; hidden_h(K-minA+1) = surf(uint8([K K;K K]), 'edgecolor', 'none'); end
hold off

uistack(hidden_h, 'bottom');

legend(hidden_h, legends(minA:maxA) )

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
