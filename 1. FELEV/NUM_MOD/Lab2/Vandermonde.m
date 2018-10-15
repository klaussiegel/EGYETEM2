% Ol�h Tam�s-Lajos
% otim1750
% 523 / 2

function OUT = Vandermonde(M)
    % Az M m�trix hosszai
    n = length(M);
    
    % L�trehozok egy M.x * M.x m�ret� m�trixot
    OUT = zeros(n);
    
    for i=1:n
        %OUT(i,:) = M(i);
        OUT(:,i) = M.^(i-1);
    end
end