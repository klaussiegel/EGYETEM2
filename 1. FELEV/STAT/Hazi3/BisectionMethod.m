function X = BisectionMethod(dist_type,parameters,eps,a,b,n)
    F = @(x)ContinuousCDF(x,dist_type,parameters);

    X = zeros(1,n);

    for i = 1:n
        aa = a;
        bb = b;
        u = ULEcuyerRNG()*(F(bb)-F(aa))+F(aa);
        x = (aa+bb)/2;

        while ( abs(F(x)-u) > eps )
            if ( F(x) < u )
                aa = x;
            else
                bb = x;
            end

            x = (aa+bb)/2;
        end

        X(i) = x;
    end
end