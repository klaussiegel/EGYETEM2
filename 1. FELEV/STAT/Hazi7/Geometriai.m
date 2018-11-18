function X = Geometriai(p,n)
    if (p<=0 || p>=1)
        error("p e (0,1)");
    end
    
    PMF = @(x)((1-p).^(x-1));
    
    X = zeros(1,n);
    
    for k=1:n
        U = ULEcuyerRNG;
        X(k) = (log(U))/(log(1-p));
    end
    
%     histogram(X);
end