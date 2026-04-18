function B = my_imfilter(I, H, padopt)
% ručna implementacija imfilter (cross-correlation)
% padopt: 'zeros' (default), 'replicate', 'symmetric'

if nargin < 3
    padopt = 'zeros';
end

% Pretvori u double za izračune
I = double(I);
[M, N] = size(I);
[kM, kN] = size(H);
padM = floor(kM/2);
padN = floor(kN/2);

%Inicijalizacija padded matrice
Ipad = zeros(M + 2*padM, N + 2*padN);

%Centralni deo
for i = 1:M
    for j = 1:N
        Ipad(i+padM, j+padN) = I(i,j);
    end
end

% Padding 
switch padopt
    case 'zeros'
    case 'replicate'
        % Gornja ivica
        for i = 1:padM
            for j = 1:N
                Ipad(i, j+padN) = I(1,j);
            end
        end
        % Donja ivica
        for i = 1:padM
            for j = 1:N
                Ipad(M+padM+i, j+padN) = I(M,j);
            end
        end
        % Leva ivica
        for i = 1:M + 2*padM
            for j = 1:padN
                Ipad(i,j) = Ipad(i,padN+1);
            end
        end
        % Desna ivica
        for i = 1:M + 2*padM
            for j = 1:padN
                Ipad(i,N+padN+j) = Ipad(i,N+padN);
            end
        end

    case 'symmetric'
        % Gornja ivica
        for i = 1:padM
            for j = 1:N
                Ipad(i,j+padN) = I(padM-i+1,j);
            end
        end
        % Donja ivica
        for i = 1:padM
            for j = 1:N
                Ipad(M+padM+i,j+padN) = I(M-i+1,j);
            end
        end
        % Leva ivica
        for i = 1:M + 2*padM
            for j = 1:padN
                Ipad(i,j) = Ipad(i,2*padN-j+1);
            end
        end
        % Desna ivica
        for i = 1:M + 2*padM
            for j = 1:padN
                Ipad(i,N+padN+j) = Ipad(i,N+padN-j+1);
            end
        end
    otherwise
        error('Nepoznat tip padding-a!');
end

% Cross-correlation
B = zeros(M,N);
for i = 1:M
    for j = 1:N
        sumVal = 0;
        for u = 1:kM
            for v = 1:kN
                sumVal = sumVal + H(u,v) * Ipad(i+u-1, j+v-1);
            end
        end
        B(i,j) = sumVal;
    end
end

end
