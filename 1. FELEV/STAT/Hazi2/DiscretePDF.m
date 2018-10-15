% Oláh Tamás-Lajos
% otim1750
% 523 / 2

% -----------
% Description
% -----------
% The function calculates the values of different discrete probability density functions.
%
% -----
% Input
% -----
% \mathbf{x} = \left[x_i\right]_{i=1}^n} - an increasing sequence of positive integers
% distribution_type                      - a string that identifies the distribution (e.g., 'Bernoulli', 
%                                          'binomial', 'Poisson', 'geometric', etc.)
% parameters                             - an array of parameters which characterize the distribution 
%                                          specified by distribution_type
%
% ------
% Output
% ------
% \mathbf{f} = \left[f(x_i)\right]_{i=1}^n - values of the given probability density function

function f = DiscretePDF(x, distribution_type, parameters)

    % for safety reasons
    sort(x);
    x = round(x);

    % get the size of the input array
    n = length(x);

    % select the corresponding distribution
    switch (distribution_type)
        case 'geometric'
            % the Geo(p}-distribution has a single parameter p in (0,1)
            p = parameters(1);

            % check the validity of the distribution parameter p
            if (p < 0 || p > 1)
                error('Wrong parameter!');
            end

            % allocate memory and evaluate the probability density function f_{Geo(p)} 
            % for each element of the input array \mathbf{x} = \left[x_i\right]_{i=1}^n}
            f = zeros(1, n);

            q = 1 - p;

            for i = 1:n
                % check the validity of the current value x_i
                if (x(i) < 1)
                    error('Incorrect input data!');
                else
                    f(i) = q^(x(i) - 1) * p; % i.e., f_{Geo(p)}(x_i) = (1-p)^{x_i} * p, i=1,2,...,n
                end
            end
            
            plot(x,f)

        % handle another discrete distribution type
        case 'poisson'
            % the Poisson(\lambda)-distribution has a single parameter \lambda,
            % where \lambda > 0
            lambda = parameters(1);

            % check the validity of the distribution parameter p
            if (lambda < 0)
                error('Wrong parameter!');
            end

            % allocate memory and evaluate the probability density function f_{Poisson(p)} 
            % for each element of the input array \mathbf{x} = \left[x_i\right]_{i=1}^n}
            f = zeros(1, n);

            for i = 1:n
                % check the validity of the current value x_i
                if (x(i)<0)
                    error('Incorrect input data!');
                else
                    f(i) = ( ( lambda^x(i) ) / ( factorial(x(i) ) ) ) * exp(1)^(-lambda);
                end
            end
            
            plot(x,f) 
        case 'hypergeometric'
            % the hypergeometric(N,M,m)-distribution has three parameters, N > 1, 0 < M < N, 0 < m < N 
            N = parameters(1);
            M = parameters(2);
            m = parameters(3);
            N = round(N);
            M = round(M);
            m = round(m);

            % check the validity of the distribution parameters N,M,m
            if ((N < 1) || (M < 0) || (M > N) || (m < 0) || (m > N))
                error('Wrong parameter !');
            end

            % allocate memory and evaluate the probability density function f_{hyge(p)} 
            f = zeros(1, n);

            for i=1:n
                % check the validity of the current value x_i
                if ((x(i) < max(0,m-N+M)) || (x(i) > min(m,M)))
                    error('Incorrect input data !');
                else
                    f(i) = nchoosek(M,x(i))*nchoosek(N-M,m-x(i))/nchoosek(N,m); % nchoosek(n,k) = n! / ( (n–k)! * k! )
                end
            end            
        case 'pascal'
            % the pascal(p)-distribution has two parameters: p in (0,1) and N>=1
            N = parameters(1);
            p = parameters(2);

            N = round(N);

            % check the validity of the distribution parameters N,p
            if ((N < 1) || (p <= 0) || (p >= 1))
                error('Wrong parameter !');
            end

            % allocate memory and evaluate the probability density function f_{nbin(N,p)} 
            f = zeros(1,n);

            for i=1:n
                % check the validity of the current value x_i
                if (x(i) < 0)
                    error('Incorrect input data !');
                else
                    f(i) = nchoosek(N+x(i)-1,x(i))*p^N*(1-p)^x(i); % nchoosek(n,k) = n! / ( (n–k)! * k! )
                end
            end
    end