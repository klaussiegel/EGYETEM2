function X = NewtonRaphsonMethod(distribution_type,n,delta)
    if (n<1)
        error("N must be >=1 !")
    end
    
    if (delta<=0)
        error("delta must be >0")
    end
    
    X = zeros(1,n);
    F = @(x)ContinuousCDF()
    
    
    for i=1:n
       U = ULEcuyerRNG;
       Xinv = URealRNG(5,'URNG1',[1,10],1);
       
       while abs(F())
           
       end
    end