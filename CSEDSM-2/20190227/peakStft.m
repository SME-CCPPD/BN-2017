%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SCRIPT DA RIVEDERE:
% * capire bene cosa tira fuori volta per volta peakEx
%   (qual'è la dimensione di peaks?)
% * Capire se è possibile fare un array dinamico di strutture
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
	peaks = peakEx(yTemp, w, N, fs, -40); 
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

%plot([0:882], peakF(:, 1:883), '.')

dur = M / fs;

fh = fopen('peakStft.sco', 'w');

for col = 1:k
	at = col * H / fs;
	for row = 1:nPartial
		fprintf(fh, "i1 %8.5f %8.5f %+9.5f %12.8f ; row=%-3d col=%-3d\n", at, dur, peakM(row, col), peakF(row, col), row, col);
	endfor
endfor

fclose(fh);
