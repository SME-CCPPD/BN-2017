clear all
close all

[y fs] = audioread("../sounds/cello-double.wav");
N = 4096;
M = 1023;
H = round(M/4);

nPartial = 150;

w = hanning(M);

peakI = zeros(nPartial, ceil(length(y)/H));
peakF = zeros(nPartial, ceil(length(y)/H));
peakM = zeros(nPartial, ceil(length(y)/H));
idx = 1;
k = 1;

while (idx + M) < length(y)
	yTemp = y(idx : idx + M - 1);
	peaks = peakEx(yTemp, w, N, fs); 
	if length(peaks) == 0
		peaks = 0;
	else
		peakI(:, k) = peaks.idx;
		peakF(:, k) = peaks.freq;
		peakM(:, k) = peaks.mag;
	end
	idx += H;
	k += 1;
end

plot([0:882], peakF(:, 1:883), '*')
