close all
clear all
pkg load signal

[x, fs] = audioread('../../sounds/piano.wav');

M = 511;
N = 1024;

w = hamming(M);

start = 0.5 * fs;

%take a portion from 0.5 sec of size M
x1 = x(start:start+M-1);

xw = x1.*w;

hN = N/2;
%small portion of M
hM1 = floor(M/2);
%big portion of M
hM2 = ceil(M/2);

fftBuffer = zeros(N, 1);

fftBuffer(1:hM2) = xw(end-hM2+1:end);
fftBuffer(end-hM1+1:end) = xw(1:hM1);

X = fft(fftBuffer);
magX = 20*log10(abs(X/size(x1, 1)));

phaX = unwrap(angle(X)); 

F = [0:fs/N:fs-fs/N];

subplot(3, 1, 1)
plot(fftBuffer)
axis([0 N])
title('segnale nel tempo')
subplot(3, 1, 2)
plot(F, magX)
axis([0 F(N/2)])
title('mag')
subplot(3, 1, 3)
plot(F, phaX)
axis([0 F(N/2)])
title('fasi')
