function X = BisectionMethod(dist_type,parameters,eps,a,b,n)
    F = @(x)ContinuousCDF(x,dist_type,parameters);
    
    for i = 1:n
        aa = a;
        bb = b;
        u = ULEcuyerRNG();
        x = (a+b)/2;
        
       while ( abs(F(x)-u) > eps ) 
           if ( u < F(x) )
               a = a;
               b = x;
           else
               a = x;
               b = b;
           end
           
           x = (a+b)/2;
       end
       
       X(i) = x;
       a = aa;
       b = bb;
    end