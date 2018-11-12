function z = fuggveny(x,y)
	if (x < pi) && (x > 0) && (y < pi) && (y > 0)
		z = 2 * ((sin(x+y))^2) / pi^2;
	else
		z = 0;
	end
end
