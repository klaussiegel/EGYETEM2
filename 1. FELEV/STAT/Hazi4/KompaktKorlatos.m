function X = KompaktKorlatos(n)
    f = @(x)(168*((x^5) - (x^7)));
    X = zeros(1,n);

    a = 0;
    b = 1;
    M = (1200/49)*sqrt(5/7);
    
    for i=1:n
        U = ULEcuyerRNG();
        V = ULEcuyerRNG();
        
        Y = a+(b-a)*V;
        
        while ~(U*M<=f(Y))
            U = ULEcuyerRNG();
            V = ULEcuyerRNG();

            Y = a+(b-a)*V;
        end
        
        X(i) = Y;
    end
    
    hist(X);
end