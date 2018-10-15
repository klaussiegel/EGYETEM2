% Oláh Tamás-Lajos
% otim1750
% 523 / 2

function OUT = Vandermonde(M)
    % Az M mátrix hosszai
    n = length(M);
    
    % Létrehozok egy M.x * M.x méretû mátrixot
    OUT = zeros(n);
    
    for i=1:n
        %OUT(i,:) = M(i);
        OUT(:,i) = M.^(i-1);
    end
end