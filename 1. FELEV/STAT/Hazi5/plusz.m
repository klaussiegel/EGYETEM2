function [X,steps] = plusz(n)
    if (n<1)
        error("N must be >=1 !")
    end
    
    steps = 0;
    
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
                steps = steps + 1;
            end
        end
        
        while (L==false)
            U = ULEcuyerRNG;
            Y = g(rand);
            W = U*c*g(Y);
            L = (W<=h1(Y));
            if (L==false)
                if (W<=h2(Y))
                    L = (W<=f(Y));
                    steps = steps + 1;
                end
            end
        end
        
        X(i) = Y;
    end
    
    disp(steps);
    
    hist(X);
    title("Plusz f�ggv�ny");
end