clear all
close all

[y fs] = audioread("../sounds/cello-double.wav");
offSet = 0.5;
M = 1023;
N = 4096;
y = y(offSet * fs : (offSet * fs) + M - 1);
w = hanning(M);
binSize = fs / N;
F = [0: binSize: fs/2 - binSize];

th = -40;

pX = peakEx(y, w, N, fs, th);

plot([pX.freq], [pX.mag]-th, '+', 'color', 'r')
