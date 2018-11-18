function X =  Kompakt_Korlatos(n)
    % Kompakt_Korlatos(50000);
    f = @(x,y)(fuggveny(x,y));
    g = @(x,y)(sin(x+y)./2);
    a = 0;
    b = pi;
    M = 1/2;
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
    
    subplot(1,2,1);
    hist3(X')
    [x,y] = meshgrid(0:0.1:pi/2,0:0.1:pi/2);
    subplot(1,2,2);
    surf(x,y,g(x,y))
    
    var(X')
    mean(X')
end