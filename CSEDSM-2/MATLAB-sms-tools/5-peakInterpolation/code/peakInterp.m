function [iploc, imag] = peakInterp(mX, ploc)
	%Peak interpolation with Parabola function
	% mX = magnitude array
	% ploc = peak location
	b = mX(ploc);
	a = mX(ploc - 1);
	y = mX(ploc + 1);

	iploc = ploc + 0.5*(a-y)/(a-2*b+y);
	imag = b - 0.25*(a-y)*(iploc-ploc);
endfunction
	
