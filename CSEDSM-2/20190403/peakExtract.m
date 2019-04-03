function peak = peakExtract (x, w, N, fs, th)
	%x = signal
	%w = window
	%N = fft size
	%fs = sample rate
	%th = peak detection threshold
		
	if nargin < 5
		th = -60;
	endif

	M = length(w);
	s = 1/sum(w);
	xw = x .* w;

	fftBuffer = zeros(N, 1);
	zP = ceil((N - M) / 2);
	fftBuffer(zP : zP + M - 1) = xw;

	binSize = fs / N;
	F = [0: binSize: fs/2 - binSize];

	X = fft( fftshift( fftBuffer ) );
	magX = 20 * log10(abs(X) * s);

	magXth = ((magX - th) .* ((magX - th) > 0) + th);

	pX = [];
	nPx = 1;

	for k = 1: length(F) - 2
		temp = magXth(k:k+2);
		[m, idx] = max(temp);
		if idx == 2
			[freq, mag] = intparab(F(k:k+2), temp);
			pX(nPx, 1) = freq;
			pX(nPx, 2) = mag; 
			nPx++;
		endif
	endfor
	peak = pX;
	
endfunction
