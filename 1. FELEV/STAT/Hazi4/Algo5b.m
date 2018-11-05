function X = Algo5b(n,mu,sigma)
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
        
        X(i) = Y * sigma + mu;
    end
    
    hist(X);
end