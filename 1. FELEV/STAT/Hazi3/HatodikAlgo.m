function X = HatodikAlgo(lambda,r)
    if (lambda<=0 || r<1)
        error("Lambda must be >0 & r must be >=1 !")
    end

    X = zeros(1,r);

    for k=1:r
        U = ULEcuyerRNG();
        i = 0;
        p = exp(-lambda);
        S = p;

        while (U>S)
            i = i+1;
            p = (lambda/i)*p;
            S = S+p;
        end

        X(k) = i;
    end

    hist(X)
end