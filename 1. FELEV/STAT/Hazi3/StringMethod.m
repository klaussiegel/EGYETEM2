function X = StringMethod(n, delta)
    % Validating arguments
    if (n < 1)
        error("N has to be >=1 !")
    end

    if (delta<=0)
        error("delta has to be >0 !")
    end

    X = zeros(1,n);
    F = @(x)ContinuousCDF(x, 'normal', [14,5]);

    for i=1:n
        a = -5;
        b = 10;
        aa = a;
        bb = b;
        U = ULEcuyerRNG() * (F(bb) - F(aa)) + F(aa);

        X(i) = a + (bb-aa)*((U-F(aa))/(F(bb)-F(aa)));

        if (F(X(i))<U)
            bb = X(i);
        else
            aa = X(i);
        end

        while (abs(b-a)>delta)
            X(i) = aa + (bb-aa)*((U-F(aa))/(F(bb)-F(aa)));

            if (F(X(i))<U)
                bb = X(i);
            else
                aa = X(i);
            end
        end
    end
end