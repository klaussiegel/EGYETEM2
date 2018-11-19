function [VARX,ELM_VARX,MEANX,ELM_MEANX] = main_1(n)
    EXP = @(lambda,n)(Exponencialis(lambda,n));
    NORM = @(mu,sigma,n)(Normalis(mu,sigma,n));
    GEO = @(p,n)(Geometriai(p,n));
    POI = @(lambda,n)(Poisson(lambda,n));
    GAM = @(a,b,n)(Gamma(a,1/b,n));

    X = zeros(5,n);
    X(1,:) = EXP(2,n);
    X(2,:) = NORM(3,2,n);
    X(3,:) = GEO(0.2,n);
    X(4,:) = POI(3,n);
    X(5,:) = GAM(3,2,n);
    
    VARX = zeros(1,5);
    ELM_VARX = zeros(1,5);
    VARX(1) = var(X(1,:)); % 1/lambda^2
    ELM_VARX(1) = 1/2^2;
    VARX(2) = var(X(2,:)); % sigma^2
    ELM_VARX(2) = 2^2;
    VARX(3) = var(X(3,:)); % (1-p)/p^2
    ELM_VARX(3) = (1-0.2)/(0.2^2);
    VARX(4) = var(X(4,:)); % lambda
    ELM_VARX(4) = 3;
    VARX(5) = var(X(5,:))*10; % a / b
    ELM_VARX(5) = 3 / 2;
    
    MEANX = zeros(1,5);
    ELM_MEANX = zeros(1,5);
    MEANX(1) = mean(X(1,:)); % 1/lambda
    ELM_MEANX(1) = 1/2;
    MEANX(2) = mean(X(2,:)); % mu
    ELM_MEANX(2) = 3;
    MEANX(3) = mean(X(3,:)); % 1/p
    ELM_MEANX(3) = 1/0.2;
    MEANX(4) = mean(X(4,:)); % lambda
    ELM_MEANX(4) = 3;
    MEANX(5) = mean(X(5,:)); % a/b^2
    ELM_MEANX(5) = 3 / 4;
    
    
    VARX
    ELM_VARX
    MEANX
    ELM_MEANX
end