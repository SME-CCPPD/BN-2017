from Grano import Grano
from Fileaudio import Fileaudio

class Granulatore:
	def __init__(self, fileaudio, grain_dur, olap, window):
		self.fileaudio = fileaudio
		self.grain_dur = grain_dur
		self.overlap = olap
		self.window = window
		self.grani = self.granula()

	def granula(self):
		step = self.grain_dur/self.overlap
		cur = 0
		res = [];
		while (cur < self.fileaudio.dur):
			res.append(Grano(self.fileaudio, cur, self.grain_dur, self.window, self.overlap))
			cur += step
		return res

	def to_csound(self):
		self.header()
		for g in self.grani:
			g.to_csound()

	def header(self):
		print('f%-2d 0 4096 20 2' % (self.window))
