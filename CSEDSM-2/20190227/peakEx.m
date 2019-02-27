function peaks = peakEx(x, w, N, fs, th)
	if nargin < 5
		th = -60;
	endif

	M = length(w);
	s = 1/sum(w);
	xW = x .* w;

	fftBuffer = zeros(N, 1);
	zP = ceil((N - M) / 2); 
	fftBuffer(zP : zP + M - 1) = xW;

	binSize = fs / N;
	F = [0: binSize: fs/2 - binSize];

	X = fft(fftshift(fftBuffer));
	magX = 20 *  log10(abs(X) * s);

	magXth = ((magX - th) .* ((magX - th) > 0)) + th;

	pX = [];
	nPx = 1;

	for k = 1:length(F)-2
		temp = magXth(k:k+2);
		[m, idx] = max(temp);
		if idx == 2
			[freq, mag] = intparab(F(k:k+2), temp);
			pX(nPx).idx = k; % k+1 - 1= k (-1 considerando lo zero)
			pX(nPx).mag = mag;
			pX(nPx).freq = freq;
			nPx++;
		endif
	endfor
peaks = pX';
end
