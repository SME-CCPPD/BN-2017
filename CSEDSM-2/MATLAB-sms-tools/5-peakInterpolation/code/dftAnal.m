function [magX, phaX] = dftAnal(x, w, N)
	%Discrete Fourier Transform  of signal x
	% x = mono signal
	% w = analysis window
	% N = sample size of DFT 
	
	hN = N/2;
	hM1 = floor(size(w, 1) / 2);
	hM2 = ceil(size(w, 1) / 2);
	
	xw = x.*w;

	fftBuffer = zeros(N, 1);
	
	fftBuffer(1:hM2) = xw(end-hM2+1:end);
	fftBuffer(end-hM1+1:end) = xw(1:hM1);
	
	X = fft(fftBuffer);
	magX = 20*log10(abs(X(1:hN)));
	phaX = unwrap(angle(X(1:hN)));

endfunction
