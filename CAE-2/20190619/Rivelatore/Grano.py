class Grano:
	def __init__(self, fileaudio, at, dur, wind, overlap):
		self.fileaudio = fileaudio
		self.at = at
		self.dur = dur
		self.wind = wind
		self.overlap = overlap

	def to_csound(self, at=None):
		at = at if at != None else self.at
		print('i1 %8.4f %8.4f %2d %8.4f %2d' % (at, self.dur, self.fileaudio, self.at, self.wind)) 
