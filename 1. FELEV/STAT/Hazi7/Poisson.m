function X = Poisson(lambda,n)
    if (lambda<=0)
        error("Lambda > 0");
    end

    X = zeros(1,n);
    for k=1:n
        U = ULEcuyerRNG;
        i = 0;
        p = exp(-lambda);
        S = p;
        
        while U>S
            i = i+1;
            p = p*(lambda/i);
            S = S+p;
        end
        
        X(k) = i;
    end
    
%     histogram(X);
end