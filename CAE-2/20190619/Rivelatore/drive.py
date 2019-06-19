import Granulatore as GR

file = GR.Fileaudio(1, '../../sounds/commendatore.wav')
gran = GR.Granulatore(file, 0.03, 4, 1)

gran.to_csound()


