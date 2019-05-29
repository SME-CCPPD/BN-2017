TARGETS = tpvoc.wav transposer.wav
PVANAL = pvoc.1 pvoc.2
PVOC = csound -U pvanal -c1
SOURCES = tpvoc.orc transposer.orc transposer.sco
CSOUND = csound -dW 
LN = ln -sf

all : $(TARGETS)

$(TARGETS) : $(PVANAL) $(SOURCES)

pvoc.1 : 
	$(PVOC) soundin.1 anal1.pvx
	$(LN) anal1.pvx $@

pvoc.2 : 
	$(PVOC) soundin.2 anal2.pvx
	$(LN) anal2.pvx $@

tpvoc.wav :
	$(CSOUND) --logfile=$@.log -o $@ tpvoc.orc transposer.sco

transposer.wav :
	$(CSOUND) --logfile=$@.log -o $@ transposer.orc transposer.sco

clean :
	$(RM) $(TARGETS) $(PVANAL) anal1.pvx anal2.pvx *.log
