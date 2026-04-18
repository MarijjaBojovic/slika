function H = my_laplacian(alpha)
% alpha u [0,1], default = 0.2

if nargin < 1
    alpha = 0.2;
end
if alpha < 0 || alpha > 1
    error('Alpha mora biti u opsegu 0 do 1!');
end

H = 4/(alpha+1)*[alpha/4 (1-alpha)/4 alpha/4;
                 (1-alpha)/4  -1 (1-alpha)/4;
                 alpha/4 (1-alpha)/4 alpha/4];

end
