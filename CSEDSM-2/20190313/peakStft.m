%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DA FARE:
% * struttura PARTIAL con start-frame, end-frame, freq & mass
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all

[y fs] = audioread("../sounds/cello-double.wav");
N = 4096;
M = 1023;
H = round(M/4);

nPartial = 150;

w = hanning(M);

PEAKS = [];

idx = 1;
k = 1;
curFrame = 1;

while (idx + M) < length(y)
	yTemp = y(idx : idx + M - 1);
	peaks = peakEx(yTemp, w, N, fs, -40); 
	if length(peaks) > 0
		PEAKS(curFrame).peaks = peaks;
		PEAKS(curFrame).frame = k;
		curFrame += 1;
	endif
	idx += H;
	k += 1;
end
