function X = KompaktKorlatos(n)
    f = @(x,y)(fuggveny(x,y));
    a = 0;
    b = pi;
    X = zeros(2,n);
    Y = zeros(1,2);
    M = (2/pi^2);
    
    for i=1:n
        U = ULEcuyerRNG * (2/pi^2);
        V1 = ULEcuyerRNG;
        V2 = ULEcuyerRNG;

        Y(1) = a+(b-a)*V1;
        Y(2) = a+(b-a)*V2;
        
        while ~(U*M<=f(Y(1),Y(2)))
             U = ULEcuyerRNG * (2/pi^2);
            U = ULEcuyerRNG;
            V1 = ULEcuyerRNG;
            V2 = ULEcuyerRNG;
            
            Y(1) = a+(b-a)*V1;
            Y(2) = a+(b-a)*V2;
        end
        
        X(1,i) = Y(1);
        X(2,i) = Y(2);
    end
    
    
     hist3(X');
end