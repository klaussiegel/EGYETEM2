function X = plusz(n)
    if (n<1)
        error("N must be >=1 !")
    end
    
    X = zeros(1,n);
    
    f = @(x)(sajatf(x));
    g = @(x)(sajatg(x));
    c = 1/4;
    h1 = @(x)(1-((sin(x+11))/(3))-(1/2));
    h2 = @(x)(1-((sin(x+11))/(20))-(0.9));
    
    for i=1:n
        U = ULEcuyerRNG;
        Y = g(rand);
        W = U*c*g(Y);
        L = (W<=h1(Y));
        if (L==false)
            if (W<=h2(Y))
                L = (W<=f(Y));
            end
        end
        
        while (L==true)
            U = ULEcuyerRNG;
            Y = g(rand);
            W = U*c*g(Y);
            L = (W<=h1(Y));
            if (L==false)
                if (W<=h2(Y))
                    L = (W<=f(Y));
                end
            end
        end
        
        X(i) = Y;
    end
    
    hist(X);
    title("Plusz függvény");
end