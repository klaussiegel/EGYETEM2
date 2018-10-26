function X = NyolcadikAlgo(p,n)
    if (n>1 || p<=0 || p>=1)
        error("Wrong parameters!")
    end

    X = zeros(1,n);

    for i = 1:n
        u = ULercuyerRNG();
        X(i) = log(1-u) / log(1-p);
    end

    hist(X,20)

end