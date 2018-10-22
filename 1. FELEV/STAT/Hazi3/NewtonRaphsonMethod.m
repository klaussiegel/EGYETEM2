function X = NewtonRaphsonMethod(n,delta)
    if (n<1)
        error("N must be >=1 !")
    end

    if (delta<=0)
        error("delta must be >0")
    end

    X = zeros(1,n);
    F = @(x)ContinuousCDF(x,'pearson',[3,1]);
    f = @(x)ContinuousPDF(x,'pearson',[3,1]);
    % X = URealRNG(5,'URNG1',0.1,5,n);

    for i=1:n
        U = ULEcuyerRNG();
        X(i) = U;

        X(i) = X(i)-( ( F(X(i)) - U ) / ( f(X(i)) ) );

        while (abs(F(X(i)))-U>delta)
            X(i) = X(i)-( ( F(X(i)) - U ) / ( f(X(i)) ) );
        end
    end

    hist(X);