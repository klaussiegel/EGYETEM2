function X = NyolcadikAlgo(p,n)
    if (n<1 || p<=0 || p>=1)
        error("Wrong parameters!")
    end

    X = zeros(1,n);
    for i=1:n
        U = ULEcuyerRNG();
        X(i) = log(1-U) / log(1-p);
    end
    
    hist(X,30);

end