function ketto(a,b,felb,felb2)
	np = @(x,X,XF)(Newton_pol(x,X,XF));
	f = @(x)(1./(1+x.^2));
	
	D = linspace(a,b,felb);
    DD = linspace(a,b,felb2);
	OUT = zeros(1,length(D));
	
	for i=1:length(DD)
		OUT(i) = np(DD(i),D,f(D));
	end
	
	plot(DD,f(DD),"r");
	hold on;
	plot(DD,OUT,"b");
    axis([a b a b])
end
