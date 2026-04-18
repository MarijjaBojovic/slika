clc; clear all; close all;

%% Učitavanje slike
I = imread("a.jpg");
I = rgb2gray(I);
I = im2double(I);

figure, imshow(I, [])
title('Ulazna slika (sa šumom)');

%% Parametri
A_values = [0.7 1 1.2 1.5 1.7 2.0]; % High-Boost faktori
padopt = 'symmetric';                % padding opcija
median_ksize = [3 3];                % veličina prozora za medijan
gauss_sigma = 1;                     % sigma za Gaussian
gauss_ksize = 3;                     
alpha = 0.2;                         % za Laplacian

%%  High-Boost direktno (bez filtriranja)

figure('Name','HB Original (bez filtriranja)');
H = my_laplacian(alpha);
for a = 1:length(A_values)
    A = A_values(a);
    B = A*I - my_imfilter(I,H,padopt);  
    B = max(min(B,1),0);               
    subplot(2,3,a)
    imshow(B,[])
    title(sprintf('HB Original, A=%.1f', A));
end

%% High-Boost + Median
I_med = my_median_filter(I, median_ksize, padopt);
figure, imshow(I_med,[]);title("slika posle my median filter")

H = my_laplacian(alpha);
figure,imshow(my_imfilter(I_med,H,padopt),[]), title('Laplacian')

figure('Name','HB + Median');
H = my_laplacian(alpha);
for a = 1:length(A_values)
    A = A_values(a);
    
    B = A*I_med - my_imfilter(I_med,H,padopt);
    B = max(min(B,1),0);                % klip u [0,1]
    
    subplot(2,3,a)
    imshow(B,[])
    title(sprintf('HB + Median, A=%.1f', A));
end

%% High-Boost + Median + Gaussian

I_med_gauss = my_gaussian_filter(I_med, gauss_sigma, gauss_ksize, padopt);
figure('Name','HB + Median + Gaussian');
H = my_laplacian(alpha);
for a = 1:length(A_values)
    A = A_values(a);
    B = A*I_med_gauss - my_imfilter(I_med_gauss,H,padopt);
    B = max(min(B,1),0);                
    subplot(2,3,a)
    imshow(B,[])
    title(sprintf('HB + Median+Gaussian, A=%.1f', A));
end

%% pomocu Gaussian usrednjavanja
I_med = my_median_filter(I, [3 3], padopt);
I_med_gauss = my_gaussian_filter(I_med, gauss_sigma, gauss_ksize, padopt);
figure('Name','HB pomocu blura');
for a = 1:length(A_values)
    A = A_values(a);
    B = A*I_med - I_med_gauss;
    subplot(2,3,a)
    imshow(B,[])
    title(sprintf('HB pomocu blura, A=%.1f', A));
end
%% cuvanje zeljene slike
A = 1.2;  % željeni High-Boost faktor
I_med = my_median_filter(I, median_ksize, padopt);
I_med_gauss = my_gaussian_filter(I_med, gauss_sigma, gauss_ksize, padopt);
B = A*I_med_gauss - my_imfilter(I_med_gauss,H,padopt);
B = max(min(B,1),0);

figure, imshow(B,[])
title(sprintf('High-Boost, A = %.1f', A))

% Sačuvaj sliku
imwrite(B, 'rezultat.png');

B = max(min(B, 1), 0);   
B_scaled = B * 255;  
B_rounded = round(B_scaled);
B_uint8 = zeros(size(B_rounded), 'uint8'); 
B_uint8(:) = B_rounded(:);   
imwrite(B_uint8, 'HighBoost_A1_2_uint8.png');