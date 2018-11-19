function X = Gamma(a,b,n)
    if (a<=0 || b<=0)
        error("a>0 , b>0")
    end

    X=zeros(1,n);
    for i=1:n
        X(i) = gamrnd(a,b);
        if (1==1)
            if (a<=0.4)
                N = a^-1;
            else
                if (a<=4)
                    N = a^-1 + a^-1 * (a-0.4)/3.6;
                else
                    N = a^(-1/2);
                end
            end

            b1 = a-1/N;
            b2 = a+1/N;

            if (a<=0.4)
                c1 = 0;
            else
                c1 = b1 * (log(b1)-1)/2;
            end

            c2 = b2 * (log(b2) - 1)/2;
            mehet = 1;

            while (mehet==1)
                v1 = ULEcuyerRNG;
                v2 = ULEcuyerRNG;

                w1 = c1 + log(v1);
                w2 = c2 + log(v2);

                y = N*(b1*w1 - b2*w2);

                while (y<0)
                    v1 = ULEcuyerRNG;
                    v2 = ULEcuyerRNG;

                    w1 = c1 + log(v1);
                    w2 = c2 + log(v2);

                    y = N*(b1*w1 - b2*w2);
                end

                x = N*(w2-w1);

                if (log(y)>=x)
                    X(i) = exp(x);
                    mehet=0;
                end
            end
        end
    end
%     histogram(X);
end