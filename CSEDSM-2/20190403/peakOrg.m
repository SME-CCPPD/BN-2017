clear all
close all

[y fs] = audioread("../sounds/cello-double.wav");
N = 4096;
M = 1023;
H = round(M/4);

rawP = peakStft(y, fs, N, M, H);

cP = [];
tol = 0.1;	%tolerance

tTol = 0.1;	%time tolerance in ms
fTol = round(tTol / (H / fs));

printf('*\n');

for n = 1: length(rawP)
	for j = 1: size(rawP(n).peaks, 1)
		check = false;
		for k = 1: length(cP)
			fCheck = cP(k).line(end, 1);
			minFC = fCheck * (1 - tol);
			maxFC = fCheck * (1 + tol);
			if rawP(n).peaks(j, 1) > minFC && rawP(n).peaks(j, 1) < maxFC
				sep = rawP(n).frame - cP(k).line(end, 3);
				printf("%d", sep)
				if sep < fTol
					add = size(cP(k).line, 1) + 1;
					%fill in the array
					cP(k).line(add, 1) = rawP(n).peaks(j, 1);	%freq
					cP(k).line(add, 2) = rawP(n).peaks(j, 2);	%mag	
					cP(k).line(add, 3) = rawP(n).frame;		%frame
					check = true;
				endif
			endif
		endfor
		printf("\n")
		if !check 
			%edit new frequency line
			newIdx = length(cP) + 1;
			cP(newIdx).line = [rawP(n).peaks(j, :), rawP(n).frame];
		endif
	endfor
endfor

hold on
for k = 1:length(cP)
	plot(cP(k).line(:, 3)*(H/fs),cP(k).line(:, 1), '*')
endfor
axis([0 6 0 5000])
hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%	struct array shape	%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%cP(k) = cP contain k frequency lines
%for each cP(k) we have an array of N rows and 3 columns 
%		      1            2          3
%cP(n).line = 	1 [frequency1, magnitude1, frame1]
%		2 [frequency2, magnitude2, frame2]
%		3 [frequency3, magnitude3, frame3]
%		N [frequencyN, magnitudeN, frameN]
%
%through the rows the array describes the moviment in frequency, 
%magnitude and time(for each frame) of every frequency line(cP(k) 
%or partial)

