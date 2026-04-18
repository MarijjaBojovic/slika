function B = my_median_filter(A, ksize, padopt)
% A - ulazna slika
% ksize - [M N] veličina prozora, default [3 3]
% padopt - 'zeros', 'symmetric', 'replicate', default 'zeros'

if nargin < 2
    ksize = [3 3];
elseif numel(ksize) == 1
    ksize = [ksize ksize];
end

if nargin < 3
    padopt = 'zeros';
end

[M, N] = size(A);
padM = floor(ksize(1)/2);
padN = floor(ksize(2)/2);

% Inicijalizacija padded matrice
Apad = zeros(M+2*padM, N+2*padN, class(A));

% Postavljanje centralnog dela
for i = 1:M
    for j = 1:N
        Apad(i+padM,j+padN) = A(i,j);
    end
end

% Ručno popunjavanje ivica
for i = 1:M+2*padM
    for j = 1:N+2*padN
        % Gornja ivica
        if i <= padM
            switch padopt
                case 'zeros'
                    Apad(i,j) = 0;
                case 'symmetric'
                    Apad(i,j) = Apad(2*padM-i+1,j);
                case 'replicate'
                    Apad(i,j) = Apad(padM+1,j);
            end
        end
        % Donja ivica
        if i > M+padM
            switch padopt
                case 'zeros'
                    Apad(i,j) = 0;
                case 'symmetric'
                    Apad(i,j) = Apad(2*(M+padM)-i+1,j);
                case 'replicate'
                    Apad(i,j) = Apad(M+padM,j);
            end
        end
        % Leva ivica
        if j <= padN
            switch padopt
                case 'zeros'
                    Apad(i,j) = 0;
                case 'symmetric'
                    Apad(i,j) = Apad(i,2*padN-j+1);
                case 'replicate'
                    Apad(i,j) = Apad(i,padN+1);
            end
        end
        % Desna ivica
        if j > N+padN
            switch padopt
                case 'zeros'
                    Apad(i,j) = 0;
                case 'symmetric'
                    Apad(i,j) = Apad(i,2*(N+padN)-j+1);
                case 'replicate'
                    Apad(i,j) = Apad(i,N+padN);
            end
        end
    end
end

% Median filtriranje 
B = zeros(M,N,class(A));
for i = 1:M
    for j = 1:N
        window = [];
        for u = 1:ksize(1)
            for v = 1:ksize(2)
                window(end+1) = Apad(i+u-1, j+v-1);
            end
        end
        window = sort(window);  % sortiranje radi medijane
        n = numel(window);
        if mod(n,2) == 1
            B(i,j) = window((n+1)/2);
        else
            B(i,j) = (window(n/2) + window(n/2+1))/2;
        end
    end
end

end
