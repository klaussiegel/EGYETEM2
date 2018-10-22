function X = BisectionMethod(dist_type,parameters,eps,a,b,n)
    F = @(x)ContinuousCDF(x,dist_type,parameters);
    
    X = zeros(1,n);
    
    for i = 1:n
        aa = a;
        bb = b;
        u = ULEcuyerRNG()*(F(b)-F(a))+F(a);
        x = (aa+bb)/2;
        
       while ( abs(F(x)-u) > eps ) 
           if ( u < F(x) )
%               a = a;
               bb = x;
           else
               aa = x;
%               b = b;
           end
           
           x = (aa+bb)/2;
       end
       
       X(i) = x;
    end