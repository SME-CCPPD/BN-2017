close all
clear all
pkg load signal

wsize = 2**13;

boxcar = ones(wsize, 1);

hann = hanning(wsize);

hamm = hamming(wsize);

black = blackman(wsize);

bh = blackmanharris(wsize);

boxcarF = 1 / sum(boxcar);
hannF = 1 / sum(hann);
hammF = 1 / sum(hamm);
blackF = 1 / sum(black);
bhF = 1 / sum(bh);

figure (1)
x = [0:wsize - 1];
plot(x, boxcar, ";rect;", x, hann, ";hanning;", x, hamm,";hamming;", x, black,";blackman;", x, bh, ";blackman-harris;")

figure(2)
stem([boxcarF hannF hammF blackF bhF]) 

figure(3)
boxcarFFT = 20 * log10(abs(fft(fftshift(boxcar.*boxcarF), wsize)));
hannFFT = 20 * log10(abs(fft(fftshift(hann.*hannF), wsize))) ;
hammFFT = 20 * log10(abs(fft(fftshift(hamm.* hammF), wsize))) ;
blackFFT = 20 * log10(abs(fft(fftshift(black.* blackF), wsize)));
bhFFT = 20 * log10(abs(fft(fftshift(bh.* bhF), wsize)) );

F = [0: wsize - 1];
plot(F, boxcarFFT, ";boxcar;", F, hannFFT, ";hanning;", F, hammFFT, ";hamming;", F, blackFFT, ";blackman;", F, bhFFT, ";blackman-harris;")
axis([wsize/2 - 30 wsize/2 + 30])
