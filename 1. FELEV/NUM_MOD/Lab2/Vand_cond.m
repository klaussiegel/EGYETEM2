% Oláh Tamás-Lajos
% otim1750
% 523 / 2

function [kond1,kond2] = Vand_cond ()
    % n = 10,...,15
    for n=10:15
        % Helyfoglalás:
        
        % t1 vektor
        % t1(k) => k=0,...,n => (k+1)=1,...,(n+1)
        t1=zeros(1,(n+1));
        
        % t2 vektor
        % t2(k) => k=1,...,n
        t2=zeros(1,n);

        % t1 kiszámolása
        for k = 0:n
            t1(k+1) = -1 + k*(2/n);
        end

        % t2 kiszámolása
        for k = 1:n
            t2(k)=k/n;
        end

        A = Vandermonde(t1);
        B = Vandermonde(t2);
        n
        kond1 = norm(A,Inf) * norm(inv(A),Inf)
        kond2 = norm(B,Inf) * norm(inv(B),Inf)
        
    end
end