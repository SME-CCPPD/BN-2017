sr = 48000
ksmps = 100
nchnls = 2
0dbfs = 1

instr 1
ifile = p4
ifdur filelen ifile
idur = p3
itranspo = ifdur / idur
icf = 600
kphase line 0, idur, ifdur

al pvoc kphase, 0.25, ifile
;al2 pvoc kphase, 1, ifile
out al

endin
