% -----------
% Description
% -----------
% The function implements the sequential inversion method(*@\footnote{\textbf{method} \emph{módszer}; \textbf{inversion $\sim$} \emph{inverziós módszer}; \textbf{rejection $\sim$} \emph{elutasításos módszer}; \textbf{squeeze $\sim$} \emph{köz\-re\-fo\-gá\-sos módszer}}@*) for finite discrete random
% variable sampling.
%
% -----
% Input
% -----
% X           - a finite discrete random variable given as a matrix in the form
%
%              [ x_1, x_2, ..., x_n;
%                p_1, p_2, ..., p_n]
%
% uniform_rng - specifies the type of the used uniform integer radom number generator,
%               can be set as 'LEcuyer'/'MersenneTwister' or 1/2 (in case of other
%               values the function it will use the built-in uniform random number
%               generator of $\GMatlab$)
%
% count       - size of the output sample
%
% ------
% Output
% ------
% sample     - a random sample of the given finite discrete random variable
%
function sample = InversionBySequentialSearch(X, uniform_rng, count)

% input checking
[row_count, column_count] = size(X);

if (row_count ~= 2)
    error('Wrong input discrete random variable!');
end

for j = 1:column_count
    if (X(2,j) < 0 || X(2,j) > 1)
        error('Wrong input discrete random variable!');
    end
end

total_probability = sum(X(2,:));
if (total_probability > 1)
    error('Wrong input discrete random variable!');
end

% assume accumulated errors
if (total_probability < 1)
    X(2, column_count) = 1 - sum(X(2, 1:column_count-1));
end

% calculate cumulative probabilities
cumulative_probabilities = cumsum(X(2,:));

% allocate memory
sample = zeros(1, count);
%U=[0.3,0.35,0.2,0.4];
% perform sequential searching(*@\footnote{\textbf{to search} \emph{keresni}; \textbf{sequential $\sim$ing} \emph{szekvenciális keresés}}@*)
for k = 1:count

    switch (uniform_rng)
        case {'LEcuyer', 1}
            u = ULEcuyerRNG();

        case {'MersenneTwister', 2}
            u = UMersenneTwisterRNG();

        otherwise
            u = rand();
    end

    b = 1;
    j = column_count;

    while (j-b==1)
        m = floor((b+j)/2);

        if (u == cumulative_probabilities(m))
            b = m; j = m;
        else
            if (u > cumulative_probabilities(m))
                b = m;
            else
                j = m;
            end
        end
    end

    if (cumulative_probabilities(b) > u)
        index = b;
    else
        index = j;
    end

    sample(k) = X(1, index);
end