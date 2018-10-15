% Oláh Tamás-Lajos
% otim1750
% 523 / 2

function gepi_eps()
    k = 1;
    while ( (1+2^(-k))-1 ~= 0)
        k=k+1;
    end
    
    epsilon = (1+2^(-k+1))-1;
    str = "(1+2^(-"+(k-1)+"))-1";
    
    disp(epsilon)
    disp(str)