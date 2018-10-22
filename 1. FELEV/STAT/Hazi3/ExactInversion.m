% X=[X_i]_{i=1}^n - denotes the sample that has to be generated
%
% distribution_type - a string that identifies the distribution of the random variate X
%
% parameters - an array that stores the parameters of the given distribution
%
% n - denotes the sample size
function X = ExactInversion(distribution_type, parameters, n)
    X = zeros(1,n);

    switch distribution_type
        case 'exponential'
            % one parameter: \lambda>0
            lambda = parameters(1);

            if (lambda<=0)
                error("Lambda has to be strictly greater than zero!")
            end

            % fx = @(x)(lambda*exp(-lambda*x));
            % Fx = @(x)(1-exp(-lambda*x));
            XFxU = @(U)(-(1/lambda)*log(U));

            for i=1:n
                U = ULEcuyerRNG;
                X(i) = XFxU(U);
            end

        case 'cauchy'
            % one parameter: \sigma>0
            sigma = parameters(1);

            if (sigma<=0)
                error("Sigma has to be strictly greater than zero!")
            end

            % fx = @(x)(sigma/(pi*(x^2+sigma^2)));
            % Fx = @(x)(1/2 + 1/pi * arctan(x/sigma));
            XFxU = @(U)(sigma*tan(pi*U));

            for i=1:n
                U = ULEcuyerRNG;
                X(i) = XFxU(U);
            end

        case 'rayleigh'
            % one parameter: \sigma>0
            sigma = parameters(1);

            if (sigma<=0)
                error("Sigma has to be strictly greater than zero!")
            end

            % fx = @(x)((x/sigma^2)*exp((a^2-x^2)/2));
            % Fx = @(x)(1-exp(-((x^2)/(x*sigma^2))));
            XFxU = @(U)(sigma*sqrt(-2*log(U)));

            for i=1:n
                U = ULEcuyerRNG;
                X(i) = XFxU(U);
            end

        case 'triangular'
            % one parameter: a>=0
            a = parameters(1);

            if (a<0)
                error("a has to be positive!")
            end

            % fx = @(x)((2/a)*(1-(x/a)));
            % Fx = @(x)((x/a)*(x-((x^2)/2*a)));
            XFxU = @(U)(a*(1-sqrt(U)));

            for i=1:n
                U = ULEcuyerRNG;
                X(i) = XFxU(U);
            end

        case 'rayleigh-end'
            % one parameter: a>0
            a = parameters(1);

            if (a<=0)
                error("a has to be strictly greater than zero!")
            end

            % fx = @(x)(x*exp((a^2 - x^2)/2));
            % Fx = @(x)(1 - exp((a^2 - x^2)/2));
            XFxU = @(U)(sqrt(a^2 - 2*log(U)));

            for i=1:n
                U = ULEcuyerRNG;
                X(i) = XFxU(U);
            end

        case 'pareto'
            % two parameters: a>0 , b>0
            a = parameters(1);
            b = parameters(2);

            if (a<=0 || b<=0)
                error("A and B has to be strictly greater than zero!")
            end

            % fx = @(x)((a*(b^a))/(x^(a+1)));
            % Fx = @(x)(1-(b/x)^a);
            XFxU = @(U)(b/(U^(1/a)));

            for i=1:n
                U = ULEcuyerRNG;
                X(i) = XFxU(U);
            end

        case 'mine'
            % two parameters: a>0 , b>0
            a = parameters(1);
            b = parameters(2);

            if (a<=0 || b<=0)
                error("A and B has to be strictly greater than zero!")
            end

            % Fx = @(x)piecewise(x<=0,0,x>0,1-exp(-(x/a)^b));
            % fx = @(x)piecewise(x<=0,0,x>0,((b/a)*((x/a)^(b-1))*(exp(-(x/a)^b))));
            XFxU = @(x)((x<=0)*0+(x>0)*sqrt(log(1/(1-x)^(-(a/b)))));

            for i=1:n
                U = ULEcuyerRNG;
                X(i) = XFxU(U);
            end

    end