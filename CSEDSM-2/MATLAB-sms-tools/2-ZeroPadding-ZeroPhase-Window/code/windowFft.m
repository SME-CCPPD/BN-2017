clear all
close all

pkg load signal

M = 511;
N = 4096;

wind = [boxcar(M), triang(M), hanning(M), hamming(M), blackmanharris(M)];

wName = {'rectangular', 'triangular', 'hamming', 'hamming', 'blackmanharris'};

hN = N/2;
hM1 = floor(M/2);
hM2 = ceil(M/2);

analW = size(wind, 2); 

i = 1;

figure(1, 'position',[0,1000,1000,1000]);
for k = 1:analW
	fftBuffer = zeros(N, 1);
	
	fftBuffer(hN+1-hM1:hN) = wind(1:hM1, k);
	fftBuffer(hN+1:hN+hM2) = wind(hM2:end, k);

	windFFT = 20*log10(abs(fft(fftBuffer)/N));

	subplot(analW, 2, i)
	plot(fftBuffer)
	axis([0 N])
	ylabel(wName{k})
	i += 1;
	subplot(analW, 2, i)
	plot(windFFT);
	axis([0 100 -200 0])
	i += 1;
endfor
