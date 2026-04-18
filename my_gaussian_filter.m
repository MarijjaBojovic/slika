function B = my_gaussian_filter(I, sigma, ksize, padopt)
% padopt: 'zeros','symmetric','replicate', default 'symmetric'

if nargin < 4
    padopt = 'symmetric';
end

half = floor(ksize/2);
n = 2*half + 1;

% ZAMENA ZA MESHGRID
X = zeros(n,n);
Y = zeros(n,n);

for i = 1:n
    for j = 1:n
        X(i,j) = j - half - 1;
        Y(i,j) = i - half - 1;
    end
end

% Gauss kernel
h = exp(-(X.^2 + Y.^2) / (2*sigma^2));
h = h / sum(h(:));   % normalizacija

% Primena filtra sa paddingom
B = my_imfilter(I, h, padopt);
end
