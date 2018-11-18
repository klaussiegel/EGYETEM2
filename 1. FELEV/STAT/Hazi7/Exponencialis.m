function X = Exponencialis(lambda,n)
    if (lambda<=0)
        error("Lambda > 0");
    end

    X = zeros(1,n);
    F_inv = @(x)((-log(x))/(lambda));
    for i=1:n
        U = ULEcuyerRNG;
        X(i) = F_inv(U);
    end
    
%     histogram(X);
end