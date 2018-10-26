function X = StringMethod(dist_type, params, a, b, eps, n)
    % Validating arguments
    if (n < 1)
        error("N has to be >=1 !")
    end

    if (eps<=0)
        error("epsilon has to be >0 !")
    end

    X = zeros(1,n);
    F = @(x)ContinuousCDF(x, dist_type, params);
    
    for i=1:n
        aa = a;
        bb = b;
        U = ULEcuyerRNG() * (F(bb) - F(aa)) + F(aa);
        
        X(i) = aa + (bb-aa)*((U-F(aa))/(F(bb)-F(aa)));

        if (F(X(i))<U)
            aa = X(i);
        else
            bb = X(i);
        end

        while (abs(F(X(i))-U)>eps)
            X(i) = aa + (bb-aa)*((U-F(aa))/(F(bb)-F(aa)));

            if (F(X(i))<U)
                aa = X(i);
            else
                bb = X(i);
            end
        end
    end
end