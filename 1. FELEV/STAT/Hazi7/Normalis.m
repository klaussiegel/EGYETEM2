function X = Normalis(mu,sigma,n)
    if (sigma<=0)
        error("sigma > 0");
    end
    
    X = zeros(1,n);
    i=1;
    
    while (i<=n) 
        U1 = ULEcuyerRNG;
        U2 = ULEcuyerRNG;
        R = sqrt(-2*log(U1));
        FI = 2*pi*U2;
        
        X(i) = R*cos(FI);
        X(i) = X(i)*sigma + mu;
        
        if (i+1<=n)
            X(i+1) = R*sin(FI);
            X(i+1) = X(i+1)*sigma + mu;
            i = i+1;
        end
        
        i = i+1;
    end
    
    histogram(X);
end