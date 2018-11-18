function X = Gamma(par,a,b,eps,n)
    X=zeros(1,n);
    f=@(x)GammaDist(par,x);
    F=@(x)ContinuousCDF(x,par);
    for i=1:n
        u = ULEcuyerRNG() * (F(b) - F(a)) + F(a);
        x = 1;
        s = 0;
        while (x-u > eps && s < 20)
            x = x - ((F(x)-u)/f(x));
            s = s + 1; 
        end
        X(i) = x;
    end
    histogram(X);
end