function [Y,epsilon,mu] = Korrelalt(p,mu1,sigma1,mu2,sigma2,n)
    if (sigma1<=0 || sigma2<=0)
        error("Sigmas must be > 0 !")
    end
    
    if (n<1)
        error("N must be > 1 !")
    end

    Y = zeros(n,2);
    mu = [mu1 ; mu2];
    epsilon = [sigma1^2 , p*sigma1*sigma2 ; p*sigma1*sigma2 , sigma2^2];
    L = [sigma1 , 0 ; p*sigma2 , sqrt(1-p^2)*sigma2];
    T = 2*pi;
    
    for k=1:n
        U1 = rand();
        U2 = rand();
        
        R = sqrt(-2*log(U1));
        theta = T*U2;
        X = [R*cos(theta) ; R*sin(theta)];
        Y(k,:) = mu + L*X;
    end
end