function main_1(n)
    EXP = @(lambda,n)(Exponencialis(lambda,n));
    NORM = @(mu,sigma,n)(Normalis(mu,sigma,n));
    GEO = @(p,n)(Geometriai(p,n));
    POI = @(lambda,n)(Poisson(lambda,n));
    GAM = @(a,b,n)(Gamma(a,b,n));

    X = zeros(5,n);
    X(1,:) = EXP(2,n);
    X(2,:) = NORM(3,2,n);
    X(3,:) = GEO(0.2,n);
    X(4,:) = POI(3,n);
    X(5,:) = GAM(1,3,n);
    
    VARX = zeros(1,5);
    VARX(1) = var(X(1,:)); % 1/lambda^2
    VARX(2) = var(X(2,:)); % sigma^2
    VARX(3) = var(X(3,:)); % (1-p)/p^2
    VARX(4) = var(X(4,:)); % lambda
    VARX(5) = var(X(5,:)); % a / b
    
    MEANX = zeros(1,5);
    MEANX(1) = mean(X(1,:)); % 1/lambda
    MEANX(2) = mean(X(2,:)); % mu
    MEANX(3) = mean(X(3,:)); % 1/p
    MEANX(4) = mean(X(4,:)); % lambda
    MEANX(5) = mean(X(5,:)); % a/b^2
    
    
    VARX
    MEANX
end