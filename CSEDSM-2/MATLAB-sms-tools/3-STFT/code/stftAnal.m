close all
clear all

pkg load signal

[x, fs] = audioread('../../sounds/piano.wav');

N = 2048;
M = 511;
H = 128;

w = hanning(M);

pin = 1;
pend = size(x, 1) - M + 1;

while pin <= pend
	x1 = x(pin:pin+M-1);
	[mX, pX] = dftAnal(x1, w, N);
	
	xmagX(:, end+1) = mX;
	xphaX(:, end+1) = pX;
	
	pin += H;
endwhile

plt = pcolor(xmagX);
set(plt, 'EdgeColor', 'none');
