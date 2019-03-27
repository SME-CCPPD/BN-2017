clear all
close all

[y fs] = audioread("../sounds/cello-double.wav");
N = 4096;
M = 1023;
H = round(M/4);

rawPEAKS = peakStft(y, fs, N, M, H);

cPEAKS = [];
tolerance = 0.1;

printf('*\n');

for k = 1:length(rawPEAKS)
	p = rawPEAKS(k).peaks;		%array di peak{freq, mag}
	frame = rawPEAKS(k).frame;
	for n = 1:length(p)
		found = false;
		pp = p(n).peak;
		for m = 1:length(cPEAKS)
			cP = cPEAKS(m);
			lastFreq = cP.freqs(end);
			maxLastFreq = lastFreq * (1+tolerance);
			minLastFreq = lastFreq * (1-tolerance);
			if pp.freq > minLastFreq && pp.freq < maxLastFreq
				cP.freqs(length(cP.freqs) + 1) = pp.freq;
				cP.mags(length(cP.mags) + 1) = pp.mag;
				cP.frames(length(cP.frames) + 1) = frame;
				found = true;
				printf('+');
			end
		end
		if !found
			newIdx = length(cPEAKS) + 1;
			cPEAKS(newIdx).freqs = [pp.freq];
			cPEAKS(newIdx).mags = [pp.mag];
			cPEAKS(newIdx).frames = [frame];
		end
	end
end
