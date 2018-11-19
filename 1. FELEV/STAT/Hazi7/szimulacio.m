function [E,VAR] = szimulacio(n)
    X = zeros(1,n);
    for i=1:n
        vege = 0;
        ido = 0;
        while (vege~=1)
            U = randi(3);
            switch (U)
                case 1
                    ido = ido + 3;
                    vege = 1;
                case 2
                    ido = ido + 5;
                case 3
                    ido = ido + 7;
            end
        end
        
        X(i) = ido;
    end
    
%     histogram(X)
    
    E = mean(X)
    VAR = var(X)
end