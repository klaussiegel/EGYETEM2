function X =  Kompakt_Korlatos(n)
    f = @(x,y)(fuggveny(x,y));
    a = 0;
    b = pi;
    M = 2/pi^2;
    X = zeros(2,n);
    
    for i = 1:n
        U = ULEcuyerRNG;
        V1 = ULEcuyerRNG; 
        V2 = ULEcuyerRNG;
        Y1 = a + (b - a) * V1;
        Y2 = a + (b - a) * V2;

         while (U*M > f(Y1,Y2))
            U = ULEcuyerRNG;
            V1 = ULEcuyerRNG; 
            V2 = ULEcuyerRNG;
            Y1 = a + (b - a) * V1;
            Y2 = a + (b - a) * V2;
         end

         X(1,i) = Y1;
         X(2,i) = Y2;
    end
end