clc; clear all; close all;

%% potiskivanje šuma
slika = imread("slika 205_1.jpg");
figure, imshow(slika)
title('Originalna slika')
figure, imhist(slika)
title("Histogram originala")

slika_f = imgaussfilt(slika);
figure, imshow(slika_f)
title('Filtrirana slika')
figure, imhist(slika_f)
title('Histogram posle filtriranja')

%% segmentacija
T = 255/2;
slikaS = slika_f >= T;
imshow(slikaS)
title('Slika nakon segmentacije')

%% popunjavanje rupa u slovima
%slikaP = imfill(slikaS,'holes');
%figure, imshow(slikaP)
%title('Slika sa popunjenim rupama')

%% labelovanje povezanih regiona
[L, n] = bwlabel(slikaS, 8);

%% prikaz i obeležavanje regiona
figure, imshow(slikaS)
title('Povezani regioni')
hold on
stats = regionprops(L, 'Centroid');
for k = 1:n
    c = stats(k).Centroid;
    text(c(1), c(2), sprintf('%d', k), 'Color', 'red')
end
hold off

%% racunanje obima
stats = regionprops(L, 'Perimeter', 'Centroid');
O = [stats.Perimeter];
C = cat(1, stats.Centroid);

figure, imshow(slikaS)
title('Povezani regioni sa obimom')
hold on
for k = 1:length(O)
    text(C(k,1), C(k,2), sprintf('%d (%.1f)', k, O(k)), 'Color', 'red');
end
hold off
%% dva najslicnija slova

i = [2 1 6 9 5 8];  % A, D, B, C, E, F
O_slova = O(i);
C_slova = C(i,:);

minDiff = Inf;
idx1 = 0;
idx2 = 0;

for m = 1:length(i)-1
    for n = m+1:length(i)
        diff = abs(O_slova(m) - O_slova(n));
        if diff < minDiff
            minDiff = diff;
            idx1 = m;
            idx2 = n;
        end
    end
end

figure, imshow(L == i(idx1) | L == i(idx2))
title(['Slova najsličnija po obimu, razlika = ', num2str(minDiff), ' px'])