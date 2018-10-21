function X = StringMethod(n, delta)
    % Validating arguments
    if (n<1)
        error("N has to be >=1 !")
    end
    
    if (delta<=0)
        error("delta has to be >0 !")
    end
    
    X = zeros(1,n);
    F = @(x)ContinuousCDF(x, 'normal', [14,5]);
    
    for i=1:n
       U = ULEcuyerRNG;
       a = 0;
       b = 1;
       
          X(i) = a + (b-a)*((U-F(a))/(F(b)-F(a)));
          
          if (F(X(i))<=U)
              a = X(i);
          else
              b = X(i);
          end;
       
       while (b-a<=delta)
          X(i) = a + (b-a)*((U-F(a))/(F(b)-F(a)));
          
          if (F(X(i))<=U)
              a = X(i);
          else
              b = X(i);
          end;
       end;
    end;