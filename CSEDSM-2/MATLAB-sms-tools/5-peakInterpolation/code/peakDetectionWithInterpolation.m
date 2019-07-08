close all
clear all

pkg load signal

[x, fs] = audioread('../../sounds/piano.wav');

N = 2048;
M = 511;
w = hanning(M);
start = 1*fs;
x1 = x(start:start+M-1);
[mX, pX] = dftAnal(x1, w, N);

th = -40;

mXth = (mX - th).*((mX - th) > 0) + th;

%normal peak detection

pX = [];
nPx = 1;

i = 1;
        
while i < size(mX, 1) - 2
        [val, idx] = max(mXth(i : i+2));
        if idx == 2
                pX(nPx).idx = i + 1;
                pX(nPx).mag = val;
                nPx += 1;
        endif
        i += 1;
endwhile

%peak detection with interpolation

ipX = [];
niPx = 1;

i = 1;

while i < size(mX, 1) - 2
	[val, idx] = max(mXth(i : i+2));
        if idx == 2
		[iploc, imag] = peakInterp(mX, i+1);
		ipX(niPx).iploc = iploc;
		ipX(niPx).imag = imag;
		niPx += 1;
	endif
	i += 1;
endwhile

figure(1)
subplot(2, 1, 1);
hold on
plot(mX)
plot([pX.idx], [pX.mag], '+', 'color', 'g');
plot([ipX.iploc], [ipX.imag], 'o', 'color', 'r');
hold off
subplot(2, 1, 2);
hold on
plot(mX)
plot([pX.idx], [pX.mag], '+', 'color', 'g');
plot([ipX.iploc], [ipX.imag], 'o', 'color', 'r');
axis([0 50])
hold off
