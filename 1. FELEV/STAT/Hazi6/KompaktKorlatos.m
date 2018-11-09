function X = KompaktKorlatos(n)
    f = @(x,y)(fuggveny(x,y));
    X = zeros(2,n);

    a = 0;
    b = 1;
    M = (1200/49)*sqrt(5/7);
    
    for i=1:n
        U = ULEcuyerRNG();
        V1 = ULEcuyerRNG();
        V2 = ULEcuyerRNG();
        
        Y1 = a+(b-a)*V1;
        Y2 = a+(b-a)*V2;
        
        while ~(U*M<=f(Y1,Y2))
            U = ULEcuyerRNG();
            V1 = ULEcuyerRNG();
            V2 = ULEcuyerRNG();

            Y1 = a+(b-a)*V1;
            Y2 = a+(b-a)*V2;
        end
        
        X(i) = Y;
    end
    
    hist(X);
end