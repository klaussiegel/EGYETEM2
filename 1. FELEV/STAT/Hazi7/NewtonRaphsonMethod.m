function X = NewtonRaphsonMethod(dist_type, par, a,b,  eps, n)
    % NewtonRaphsonMethod('gamma',[1,1],0,15,eps,500);hold on;NewtonRaphsonMethod('gamma',[2,1],0,15,eps,500);	
	X=zeros(1,n);
    F=@(x)ContinuousCDF(x,dist_type,par);
    f=@(x)ContinuousPDF(x,dist_type,par);

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