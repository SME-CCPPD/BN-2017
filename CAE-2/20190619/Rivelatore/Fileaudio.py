from scipy.io.wavfile import read

class Fileaudio:
	def __init__(self, idx, path):
		self.idx = idx
		self.path = path
		self.fs, self.audio_left, self.audio_right = self.read_fileaudio()
		self.dur = self.calc_dur(); 

	def calc_dur(self):
		return len(self.audio_left)/self.fs

	def read_fileaudio(self):
		fs, audio = read(self.path)
		al = []
		ar = []
		for stereo in audio:
			al.append(stereo[0])
			ar.append(stereo[1])
		return fs, al, ar	
