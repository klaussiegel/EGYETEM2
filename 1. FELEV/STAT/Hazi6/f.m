function z = f(x,y)
	if ((x>0 && x<pi) && (y>0 && y<pi))
		z = 2 * ((sin(x+y))^2) / pi^2;
	else
		z = 0;
	end
end
