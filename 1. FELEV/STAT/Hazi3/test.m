function [] = test()
    figure;
    hist(ExactInversion('exponential', 1, 1000), 30);
    title('exponential');

    figure;
    hist(ExactInversion('cauchy', 1, 1000), 30);
    title('cauchy');

    figure;
    hist(ExactInversion('rayleigh', 1, 1000), 30);
    title('rayleigh');

    figure;
    hist(ExactInversion('triangular', 1, 1000), 30);
    title('triangular');

    figure;
    hist(ExactInversion('rayleigh-end', 1, 1000), 30);
    title('rayleigh-end');

    figure;
    hist(ExactInversion('pareto', [1, 2], 1000), 30);
    title('pareto');

    figure;
%     plot(x, @(x)ContinuousPDF(x, 'mine', [1,2]));
%     plot(x, @(x)ContinuousCDF(x, 'mine', [1,2]));
    hist(ExactInversion('mine', [1, 2], 1000));
    title('az a masik...')

    figure;
    hist(BisectionMethod('normal', [2, 5], 0.01, -5, 10, 1000), 30);
    title('felezo modszer');

    figure;
    hist(StringMethod('normal',[2,5],-5,10,0.01,1000), 30);
    title('hur modszer');

    figure;
    hist(NewtonRaphsonMethod('pearson', [3,1], 0.1, 5, 0.01, 1000), 30);
    title('Newton-Raphson modszer');

    figure;
    hist(HatodikAlgo(5, 10000));
    title('Poisson')

    figure;
    hist(NyolcadikAlgo(1/2, 10000), 30);
    title('geometriai');

    Feladat5(5000,1)
end