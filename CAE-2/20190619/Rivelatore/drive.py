import Granulatore as GR

file = GR.Fileaudio(1, 160)
gran = GR.Granulatore(file, 0.03, 4, 1)

gran.to_csound()


