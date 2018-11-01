function X = Algo5(n)
    X = zeros(1,n);
    a = (sqrt(exp(1)) / 2);
    
    for i=1:n
        U = ULEcuyerRNG;
        V = ULEcuyerRNG;
        Y = tan(pi*V);
        S = Y^2;
        
        while (~(U<=a*(1+S)*exp(-(S/2))))
            U = ULEcuyerRNG;
            V = ULEcuyerRNG;
            Y = tan(pi*V);
            S = Y^2;
        end
        
        X(i) = Y;
    end
    
    hist(X); hold on;
end