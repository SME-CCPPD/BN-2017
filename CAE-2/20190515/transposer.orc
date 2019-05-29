sr = 44100
ksmps = 100
nchnls = 2
0dbfs = 1

instr 1
ifile = p4
ifdur filelen ifile
idur = p3
itranspo = ifdur / idur
icf = 600

print ifdur, idur, itranspo


aoutl diskin2 ifile, itranspo
al buthp aoutl, icf
;ar buthp aoutr, icf
al balance al, aoutl
;ar balance ar, aoutr
	outs al, al

endin
