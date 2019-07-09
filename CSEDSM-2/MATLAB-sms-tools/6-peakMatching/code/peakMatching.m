clear all
close all

[y fs] = audioread("../../sounds/cello-double.wav");
N = 4096;
M = 1023;
H = round(M/4);

rawP = peakStft(y, fs, N, M, H);

cP = [];
tol = 0.05;	%tolerance

tTol = 0.1;	%time tolerance in ms
fTol = round(tTol / (H / fs));

for n = 1: length(rawP)
	for j = 1: size(rawP(n).peaks, 1)
		check = false;
		for k = 1: length(cP)
			fCheck = cP(k).line(end, 1);
			minFC = fCheck * (1 - tol);
			maxFC = fCheck * (1 + tol);
			if rawP(n).peaks(j, 1) > minFC && rawP(n).peaks(j, 1) < maxFC
				sep = rawP(n).frame - cP(k).line(end, 3);
				if sep < fTol
					add = size(cP(k).line, 1) + 1;
					%fill in the array
					cP(k).line(add, 1) = rawP(n).peaks(j, 1);	%freq
					cP(k).line(add, 2) = rawP(n).peaks(j, 2);	%mag	
					cP(k).line(add, 3) = rawP(n).frame;		%frame
					check = true;
					break
				endif
			endif
		endfor
		if !check 
			%edit new frequency line
			newIdx = length(cP) + 1;
			cP(newIdx).line = [rawP(n).peaks(j, :), rawP(n).frame];
		endif
	endfor
endfor
