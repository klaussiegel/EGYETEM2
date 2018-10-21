function X = HalfMethod(n,delta)
    % Validating arguments
    if (n<1)
        error("N has to be >=1 !")
    end
    
    if (delta<=0)
        error("delta has to be >0 !")
    end

    X = zeros(1,n);
%     f = @(x)ContinuousPDF(x, distribution_type, parameters);
    F = @(x)ContinuousCDF(x, 'normal', [1,200]);
    
    a = -100;
    b = 0;
    
    for i=1:n
           U = ULEcuyerRNG;
       
       % SIMULATING DO...WHILE LOOP
           X(i)=(a+b)/2;

          if (F(X(i))<=U)
              a = X(i); 
          else
              b = X(i);
          end

           while (b-a<=2*delta)
              X(i)=(a+b)/2;

              if (F(X(i))<=U)
                  a = X(i); 
              else
                  b = X(i);
              end
           end 
    end