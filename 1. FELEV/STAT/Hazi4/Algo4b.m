function X = Algo4b(n,mu,sigma)
    X = zeros(1,n);
    
    for i=1:n
        Y = exprnd(1);
        V = -1 + (1+1)*rand;
        
        while ~((Y-1)^2 <= -2*log(abs(V)))
            Y = exprnd(1);
            V = -1 + (1+1)*rand;
        end
        
        X(i) = Y * sign(V) * sigma + mu;
        
    end
    
    histogram(X);
end