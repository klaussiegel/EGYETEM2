n = 100000;
leptek = 0.1;
g=@(x,y)(2 .* ((sin(x+y)).^2) / (pi.^2));
[x,y] = meshgrid(0:leptek:pi,0:leptek:pi);
x1 = linspace(0,pi,n);
x2 = linspace(0,pi,n);

X = Kompakt_Korlatos(n);

subplot(1,3,1);
surf(x,y,g(x,y));
subplot(1,3,2);
scatter(X(1,:), X(2,:), '.');
subplot(1,3,3);
histogram2(X(1,:), X(2,:));