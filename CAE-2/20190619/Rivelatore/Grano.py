import numpy as np

class Grano:
	def __init__(self, fileaudio, at, dur, wind, overlap):
		self.fileaudio = fileaudio
		self.at = at
		self.dur = dur
		self.wind = wind
		self.overlap = overlap
		self.rms = self.calc_rms();

	def to_csound(self, at=None):
		at = at if at != None else self.at
		print('i1 %8.4f %8.4f %2d %8.4f %2d ;rms-left :%8.4f, rms-right %8.4f' % (at, self.dur, self.fileaudio.idx, self.at, self.wind, self.rms[0], self.rms[1])) 

	def calc_rms(self):
		start_sample = int(self.at*self.fileaudio.fs)
		end_sample = int((self.at+self.dur)*self.fileaudio.fs)
		s_left = self.fileaudio.audio_left[start_sample: end_sample]
		s_right = self.fileaudio.audio_right[start_sample: end_sample]
		rms_left = np.sum(np.abs(s_left))/len(s_left)
		rms_right = np.sum(np.abs(s_right))/len(s_right)
		
		return [rms_left, rms_right] 

