% Oláh Tamás-Lajos
% otim1750
% 523 / 2

function test
    %Geometriai
        figure(1);
                x = 1:1:10;
            [a] = DiscretePDF(x,'geometric',1/3); 
                subplot(1,2,1);
                plot(x,a,'g.');
                hold on;
            [b] = DiscreteCDF(x,'geometric',1/3);
                plot(x,b,'b.');
                title('Geometric')

            [c] = geopdf(x,1/3);
                subplot(1,2,2);
                plot(x,c,'g.');
                hold on;
            [d] = geocdf(x,1/3);
                plot(x,d,'b.');
                title('Geometric (Matlab)')

    %Poisson
        figure(2);
                x = 1:1:10;
            [a] = DiscretePDF(x,'poisson',1/2); 
                subplot(1,2,1);
                plot(x,a,'g.');
                hold on;
            [b] = DiscreteCDF(x,'poisson',1/2);
                plot(x,b,'b.');
                title('Poisson')

            [c] = poisspdf(x,1/2);
                subplot(1,2,2);
                plot(x,c,'g.');
                hold on;
            [d] = poisscdf(x,1/2);
                plot(x,d,'b.');
                title('Poisson (Matlab)')

    %Hypergeometric
        figure(3);
                x = 1:1:10;
            [a] = DiscretePDF(x,'hypergeometric',[20,11,10]); 
                subplot(1,2,1);
                plot(x,a,'g.');
                hold on;
            [b] = DiscreteCDF(x,'hypergeometric',[20,11,10]);
                plot(x,b,'b.');
                title('Hypergeometric')

            [c] = hygepdf(x,20,11,10);
                subplot(1,2,2);
                plot(x,c,'g.');
                hold on;
            [d] = hygecdf(x,20,11,10);
                plot(x,d,'b.');
                title('Hypergeometric (Matlab)')

    %Pascal
        figure(4);
                x = 1:1:10;
            [a] = DiscretePDF(x,'pascal',[3,1/2]); 
                subplot(1,2,1);
                plot(x,a,'g.');
                hold on;
            [b] = DiscreteCDF(x,'pascal',[3,1/2]);
                plot(x,b,'b.');
                title('Pascal')

            [c] = nbinpdf(x,3,1/2);
                subplot(1,2,2);
                plot(x,c,'g.');
                hold on;
            [d] = nbincdf(x,3,1/2);
                plot(x,d,'b.');
                title('Pascal (Matlab)')

    %Normal
        figure(5);
                x = 1:0.001:10;
            [a] = ContinuousPDF(x,'normal',[0 2]); 
                subplot(1,2,1);
                plot(x,a,'g');
                hold on;
            [b] = ContinuousCDF(x,'normal',[0 2]);
                plot(x,b,'b')
                title('Normal')

            [c] = normpdf(x,0,2);
                subplot(1,2,2);
                plot(x,c,'g');
                hold on;
            [d] = normcdf(x,0,2);
                plot(x,d,'b');
                title('Normal (Matlab)')

    %Gamma
        figure(6);
                x = 1:0.001:10;
            [a] = ContinuousPDF(x,'gamma',[2 1]); 
                subplot(1,2,1);
                plot(x,a,'g');
                hold on;
            [b] = ContinuousCDF(x,'gamma',[2 1]);
                plot(x,b,'b')
                title('Gamma')

            [c] = gampdf(x,2,1);
                subplot(1,2,2);
                plot(x,c,'g');
                hold on;
            [d] = gamcdf(x,2,1);
                plot(x,d,'b');
                title('Gamma (Matlab)')

    %Exponencialis
        figure(7);
                x = 1:0.001:10;
            [a] = ContinuousPDF(x,'exponential', 1/4); 
                subplot(1,2,1);
                plot(x,a,'g');
                hold on;
            [b] = ContinuousCDF(x,'exponential',1/4);
                plot(x,b,'b')
                title('Exponential')

            [c] = exppdf(x,4);
                subplot(1,2,2);
                plot(x,c,'g');
                hold on;
            [d] = expcdf(x,4);
                plot(x,d,'b');
                title('Exponential (Matlab)')

    %Uniform
        figure(8);
                x = 1:0.001:10;
            [a] = ContinuousPDF(x,'uniform',[2 5]); 
                subplot(1,2,1);
                plot(x,a,'g');
                hold on;
            [b] = ContinuousCDF(x,'uniform',[2 5]);
                plot(x,b,'b')
                title('Uniform')

            [c] = unifpdf(x,2,5);
                subplot(1,2,2);
                plot(x,c,'g');
                hold on;
            [d] = unifcdf(x,2,5);
                plot(x,d,'b');
                title('Uniform (Matlab)')