function X = GammaDist(parameters,x)
    a = parameters(1);
    b = parameters(2);

    if (a<=0) 
        error('Parameter error!');
    end

    if (b<=0) 
        error('Parameter error!');
    end
        
    X = ((1/(b.^a.*gamma(a)).*x.^(a-1).*exp(-x/b)).*(x>=0));
end