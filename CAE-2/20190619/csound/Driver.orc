sr = 44100
ksmps = 10
nchnls = 2

instr 1

ifile = p4
iskip = p5
iwin = p6
idur = p3

kwin oscil1 0, 1, idur, iwin

al, ar soundin ifile, iskip

al = al*kwin
ar = ar*kwin

outs al, ar

endin
