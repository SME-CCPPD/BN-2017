function p = peakStft(y, fs, N, M, H)
	w = hanning(M);
	p = [];

	idx = 1;
	k = 1;
	curFrame = 1;

	while (idx + M) < length(y)
		yTemp = y(idx : idx + M - 1);
		peaks = peakExtract(yTemp, w, N, fs, -40); 
		if length(peaks) > 0
			p(curFrame).peaks = peaks;
			p(curFrame).frame = k;
			curFrame += 1;
		endif
		idx += H;
		k += 1;
	end
end

