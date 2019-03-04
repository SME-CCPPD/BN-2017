# CSEDSM II - Lezione del 27 febbraio 2019

## Argomenti

* Ricostruzione degli sms-tools con `matlab`/`octave`:
  * *Short Time Fourier Transform* con estrazione dei picchi
  * scrittura di una partitura `csound` con i picchi estratti (da completare)

## Esempi `octave`:

[Funzione completa di estrazione dei picchi (riveduta e corretta)](./peakEx.m)

```matlab
function peaks = peakEx(x, w, N, fs, th)
	if nargin < 5
		th = -60;
	endif

	M = length(w);
	s = 1/sum(w);
	xW = x .* w;

	fftBuffer = zeros(N, 1);
	zP = ceil((N - M) / 2); 
	fftBuffer(zP : zP + M - 1) = xW;

	binSize = fs / N;
	F = [0: binSize: fs/2 - binSize];

	X = fft(fftshift(fftBuffer));
	magX = 20 *  log10(abs(X) * s);

	magXth = ((magX - th) .* ((magX - th) > 0)) + th;

	pX = [];
	nPx = 1;

	for k = 1:length(F)-2
		temp = magXth(k:k+2);
		[m, idx] = max(temp);
		if idx == 2
			[freq, mag] = intparab(F(k:k+2), temp);
			pX(nPx).idx = k; % k+1 - 1= k (-1 considerando lo zero)
			pX(nPx).mag = mag;
			pX(nPx).freq = freq;
			nPx++;
		endif
	endfor
peaks = pX';
end
```

[Funzione di test per l'estrazione dei picchi spettrali](./peakEx_test.m)

```matlab
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
```

[Estrazione completa dei picchi spettrali](./peakStft.m)

```matlab
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
```

Questo codice produce il seguente grafico:

![Estrazione completa dei picchi spettrali](./peakStft.jpg)

[Estrazione dei picchi ed elaborazione di codice `csound` con i picchi estratti (non corretta)](./peakStft.m)

```matlab
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
```
