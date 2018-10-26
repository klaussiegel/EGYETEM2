function X = NewtonRaphsonMethod(dist_type, params, a, b, eps, n)
    if (n<1)
        error("N must be >=1 !")
    end

    if (eps<=0)
        error("delta must be >0")
    end

    X = zeros(1,n);
    F = @(x)ContinuousCDF(x,dist_type,params);
    f = @(x)ContinuousPDF(x,dist_type,params);
    % X = URealRNG(5,'URNG1',0.1,5,n);
    init = 3;
    stop = 1000;

    for i=1:n
        seged = init;
        U = ULEcuyerRNG() * (F(b) - F(a)) + F(a);
        
        while (1)
            ctrl = 0;
            X(i) = seged;

            X(i) = X(i)-( ( F(X(i)) - U ) / ( f(X(i)) ) );

            while (abs(F(X(i)))-U > eps && ctrl < stop)
                X(i) = X(i)-( ( F(X(i)) - U ) / ( f(X(i)) ) );
                ctrl = ctrl + 1;
            end
            
            if (ctrl < stop)
                break;
            else
                seged = seged - 0.1;
            end
        end
    end

    hist(X);
end